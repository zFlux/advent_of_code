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
    attr_reader :condition_records, :count_records, :group_start_positions

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
        @group_start_positions = []
        @acc = []
        @counts = {}
        find_first_group_positions
        @group_start_positions = @acc.reverse
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
end

#puts ChallengeTwelve.solutions('input_test_part1.txt')