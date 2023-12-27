require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwelve
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            spring_groups = []
            input_list.each do |line|
                spring_group = SpringGroup.new(line, true)
                spring_groups << spring_group
            end
            [0, 0]
        end
    end
end

class SpringGroup
    attr_reader :condition_records, :count_records, :start_points

    OPERATIONAL = '.'
    DAMAGED = '#'
    UNKNOWN = '?'

    def initialize(input, unfolded = false)
        split_input = input.split(' ')
        @condition_records = split_input[0]
        @count_records = split_input[1].split(',')
        @count_records.map!(&:to_i)
        if unfolded
            @condition_records += ("?" + @condition_records) * 4
            @count_records += @count_records * 4
        end
        @acc = []
        @cached_counts = {}
        find_first_group_positions
        @start_points = @acc.reverse
    end

    def find_first_group_positions(search_index = 0, group_index = 0)
        if group_index >= @count_records.length
            return condition_records_above_are_not_damaged?(search_index)
        end

        if search_index >= @condition_records.length && group_index < @count_records.length
            return false
        end

        group_size = @count_records[group_index]
        slice_to_check = @condition_records[search_index..(search_index + group_size)]
        #puts "Group Index: #{group_index} Group Size: #{group_size} Slice to check: #{slice_to_check} can contain group: #{can_contain_group(slice_to_check, group_size)}"

        # if this slice can contain the current group
        if can_contain_group(slice_to_check, group_size)
            # and the subsequent groups can be found in the remaining string
            if find_first_group_positions(search_index + group_size + 1, group_index + 1)
                # then we've found a valid group
                @acc << search_index
                return true
            elsif @condition_records[search_index] == UNKNOWN || @condition_records[search_index] == OPERATIONAL
                find_first_group_positions(search_index + 1, group_index)
            else
                false
            end
        # if we're not moving past a damaged section
        elsif @condition_records[search_index] == UNKNOWN || @condition_records[search_index] == OPERATIONAL
            find_first_group_positions(search_index + 1, group_index)
        else
            false
        end
    end

    def condition_records_above_are_not_damaged?(index)
        !@condition_records[index..-1] || @condition_records[index..-1].split('').all? { |char| char == UNKNOWN || char == OPERATIONAL }
    end

    def can_contain_group(string, group_size)
        group_size.times do |index|
            if string[index] == OPERATIONAL
                return false
            end
        end
        string[group_size] != DAMAGED
    end


    def find_possibilities
        # going backwards through the start points,
        # compute the count of possibilities from a given point
        # and store it in the cache
        byebug
        (@start_points.length - 1).downto(0).each do |group_index|
            group_starts = @start_points[group_index]
            # take the groups first start point
            group_start = group_starts[0]
            # take the groups size
            group_size = @count_records[group_index]
            # find all remaining start points
            start = group_start + 1
            last = 0
            if group_index == @start_points.length - 1
                # if this is the first group (last group) then the last possible start point is the last index minus the group size
                last = @condition_records.length - group_size
            else
                # otherwise the last possible start point is the last start point of the previous group minus the group size
                previous_groups_starts = @start_points[group_index + 1]
                previous_groups_last_start = previous_groups_starts[previous_groups_starts.length - 1]
                last = previous_groups_last_start - group_size - 1
            end

            (start..last).each do |index|
                new_start = find_damaged_group_at(index, group_size)
                if new_start
                    group_starts << new_start
                end
            end
        end

        # now that we have all the start points, we can compute the number of possibilities
        # starting with the final group

        # for each of the starting points in the final group store a value in the hash that associates
        # that group and start point with the possibility count of 1
        @start_points[@start_points.length - 1].each do |start_point|
            @cached_counts[[@start_points.length - 1, start_point]] = 1
        end

        # for the counts of all the other groups, starting with the second to last group
        # and going backwards, compute the count of possibilities for each start point
        # and store it in the hash
        (@start_points.length - 2).downto(0).each do |group_index|
            group_starts = @start_points[group_index]
            group_starts.each do |start_point|
                count = 0
                next_group_starts = @start_points[group_index + 1]
                next_group_starts.each do |next_start_point|
                    if next_start_point > start_point + @count_records[group_index]
                        count += @cached_counts[[group_index + 1, next_start_point]]
                    end
                end
                @cached_counts[[group_index, start_point]] = count
            end
        end

        # possibilities are equal to the sum of possibilities for all possible start positions of the first group
        possibilities = 0
        @start_points[0].each do |start_point|
            possibilities += @cached_counts[[0, start_point]]
        end
        possibilities
    end
end

#puts ChallengeTwelve.solutions('input_test_part1.txt')