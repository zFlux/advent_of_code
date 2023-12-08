require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeFive
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            seeds = input_list[0].split(' ')[1..-1].map(&:to_i)
            almanac_strings = input_list[2..-1]
            garden_almanac = GardenAlmanac.new(almanac_strings)

            # Part 1
            location_distances = []
            seeds.map do |seed|
                location_distances << garden_almanac.find_location_from_seed(seed)
            end
            part_1 = location_distances.min
            part_1

            # Part 2
            location_ranges = []
            seed_ranges = ResourceRangeList.new(seeds)
            location_ranges = garden_almanac.find_location_range_from_seed_ranges(seed_ranges)
            # find the array with the smallest first element
            part_2 = location_ranges.min_by(&:range_start).range_start
            [part_1, part_2]
        end
    end
end

class GardenAlmanac
    attr_reader :resource_maps

    def initialize(almanac_strings)
        @resource_maps = parse_resource_maps(almanac_strings)
    end

    def find_location_from_seed(seed_num)
        curr_num = seed_num
        # print "Seed: #{seed_num}"
        @resource_maps.each do |resource_map|
            curr_num = resource_map.map_source_resource_to_dest(curr_num)
          #  puts resource_map.name
          #  puts curr_num
        end
        curr_num
    end

    # Takes a list of seed ranges and returns a list of location ranges
    def find_location_range_from_seed_ranges(seed_ranges)
        curr_seed_ranges = seed_ranges.resource_ranges
        #print "Seed Ranges: #{seed_ranges.inspect}"
        @resource_maps.each do |resource_map|
            curr_seed_ranges = resource_map.map_source_resource_ranges_to_dest_ranges(curr_seed_ranges)
            #puts resource_map.name
            #puts curr_seed_ranges.inspect
        end
        curr_seed_ranges
    end

    def parse_resource_maps(almanac_strings)
        resource_map_name = ''
        resource_map_ranges = []
        @resource_maps = []
        almanac_strings.each do |almanac_string|
            if almanac_string.include?(':')
                resource_map_name = almanac_string.split(':')[0]
            elsif almanac_string.match?(/\d/)
                resource_map_ranges << MapRange.new(almanac_string.split(' ').map(&:to_i))
            else
                @resource_maps << ResourceMap.new(resource_map_name, resource_map_ranges)
                resource_map_ranges = []
            end
        end
        @resource_maps << ResourceMap.new(resource_map_name, resource_map_ranges)
        @resource_maps
    end
end

class ResourceMap
    attr_reader :name, :resource_map_ranges

    def initialize(name, resource_map_ranges)
        @name = name
        @resource_map_ranges = resource_map_ranges
    end

    def map_source_resource_to_dest(source_num)
        @resource_map_ranges.each do |resource_map_range|
            dest_num = resource_map_range.map(source_num)
            return dest_num if dest_num
        end
        source_num
    end

    # Takes a list of resource ranges and returns a list of destination resource ranges
    def map_source_resource_ranges_to_dest_ranges(ranges)
        result_arr = []
        unprocessed = []
        ranges.each do |range|
            mapped_parts = []
            unprocessed = [range]
            @resource_map_ranges.each do |resource_map_range|
                unmapped = []
                unprocessed.each do |unprocessed_range| 
                    result = resource_map_range.map_range(unprocessed_range)
                    mapped_parts+=result[:mapped]
                    unmapped+=result[:unmapped]
                end
                unprocessed = unmapped
            end
            result_arr += mapped_parts
            result_arr+=unprocessed
        end
        # if none of the maps have mapped the the range then return the original range
        result_arr
    end
end

class ResourceRangeList
    attr_reader :resource_ranges

    def initialize(range_list)
        @resource_ranges = []
        range_list.each_slice(2) do |range_list|
            @resource_ranges << ResourceRange.new(range_list)
        end
    end
end

class ResourceRange
    attr_reader :range_start, :range_length

    def initialize(range_list)
        @range_start = range_list[0]
        @range_length= range_list[1]
    end

    def inspect
        "[#{@range_start}, #{@range_length}]"
    end
end

class MapRange
    attr_reader :dest_range_start, :source_range_start, :range_length

    def initialize(range_list)
        @dest_map_range_start = range_list[0] 
        @source_map_range_start = range_list[1] 
        @range_map_length = range_list[2] 
    end

    def inspect
        "[#{@dest_map_range_start}, #{@source_map_range_start}, #{@range_map_length}]"
    end

    def map(source_num)
        if source_num >= @source_map_range_start && source_num < @source_map_range_start + @range_map_length
            offset = source_num - @source_map_range_start
            @dest_map_range_start + offset
        else
            nil
        end
    end

    # returns a list of ranges
    def map_range(range)
        if map_range_contains_range(range)
            # then the entire range is mapped so return the mapped range
            offset_start = range.range_start - @source_map_range_start
            dest_start = @dest_map_range_start + offset_start
            return { mapped: [ResourceRange.new([dest_start, range.range_length])], unmapped: []}
        elsif range_contains_map_range(range)
            # then there are three ranges to return
            # 1. the range before the mapped range
            first_range = ResourceRange.new([range.range_start, @source_map_range_start - range.range_start])
            # 2. the mapped range
            second_range = ResourceRange.new([@dest_map_range_start, @range_map_length])
            # 3. the range after the mapped range
            third_range = ResourceRange.new([@source_map_range_start + @range_map_length, (range.range_start + range.range_length) - (@source_map_range_start + @range_map_length) ])
            return {mapped: [second_range], unmapped: [first_range, third_range]}
        elsif range_is_partially_mapped_at_the_end(range)
            # then there are two ranges to return
            # 1. the range before the mapped range
            first_range = ResourceRange.new([range.range_start, @source_map_range_start - range.range_start])
            # 2. the mapped range
            offset = (range.range_start + range.range_length) - @source_map_range_start 
            second_range = ResourceRange.new([@dest_map_range_start, offset])
            return {mapped: [second_range], unmapped: [first_range]}
        elsif range_is_partially_mapped_at_the_start(range)
            # then there are two ranges to return
            # 1. the mapped range
            offset = @source_map_range_start + @range_map_length - range.range_start
            first_range = ResourceRange.new([@dest_map_range_start + (range.range_start - @source_map_range_start), offset])
            # 2. the range after the mapped range
            second_range = ResourceRange.new([@source_map_range_start + @range_map_length, range.range_length - offset ])
            return {mapped: [first_range], unmapped: [second_range]}
        else
            # then the range is not mapped at all
            return {mapped: [], unmapped: [range]}
        end
    end

    def map_range_contains_range(range)
        range.range_start >= @source_map_range_start && range.range_start < @source_map_range_start + @range_map_length && range.range_start + range.range_length <= @source_map_range_start + @range_map_length
    end

    def range_contains_map_range(range)
        @source_map_range_start > range.range_start && @source_map_range_start < range.range_start + range.range_length && @source_map_range_start + @range_map_length < range.range_start + range.range_length
    end

    def range_is_partially_mapped_at_the_end(range)
        range.range_start <= @source_map_range_start && range.range_start + range.range_length > @source_map_range_start && range.range_start + range.range_length <= @source_map_range_start + @range_map_length
    end

    def range_is_partially_mapped_at_the_start(range)
        range.range_start >= @source_map_range_start && range.range_start < @source_map_range_start + @range_map_length && range.range_start + range.range_length >= @source_map_range_start + @range_map_length
    end
end

puts ChallengeFive.solutions('input.txt')




