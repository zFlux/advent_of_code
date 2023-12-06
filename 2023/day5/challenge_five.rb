require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeFive
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            seeds = input_list[0].split(' ')[1..-1].map(&:to_i)
            almanac_strings = input_list[2..-1]
            garden_almanac = GardenAlmanac.new(almanac_strings)

            location_distances = []
            seeds.map do |seed|
                location_distances << garden_almanac.find_location_from_seed(seed)
            end
            part_1 = location_distances.min
            part_1
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

    def parse_resource_maps(almanac_strings)
        resource_map_name = ''
        resource_map_ranges = []
        @resource_maps = []
        almanac_strings.each do |almanac_string|
            if almanac_string.include?(':')
                resource_map_name = almanac_string.split(':')[0]
            elsif almanac_string.match?(/\d/)
                resource_map_ranges << Range.new(almanac_string.split(' ').map(&:to_i))
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
end

class Range
    attr_reader :dest_range_start, :source_range_start, :range_length

    def initialize(range_list)
        @dest_range_start = range_list[0] 
        @source_range_start = range_list[1] 
        @range_length = range_list[2] 
    end

    def inspect
        "[#{@dest_range_start}, #{@source_range_start}, #{@range_length}]"
    end

    def map(source_num)
        if source_num >= @source_range_start && source_num < @source_range_start + @range_length
            offset = source_num - @source_range_start
            @dest_range_start + offset
        else
            nil
        end
    end
end

puts ChallengeFive.solutions('input.txt')




