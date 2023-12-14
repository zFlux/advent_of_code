require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwelve
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            part1_spring_groups = []
            part2_spring_groups = []
            input_list.each do |line|
                part1_spring_groups << SpringGroup.new(line)
                part2_spring_groups << SpringGroup.new(line, true)
            end

            part1_arrangements = []
            part1_spring_groups.each do |spring_group|
                part1_arrangements << spring_group.arrangements.size
            end
            part1_arrangements.sum

            part2_arrangements = []
            part2_spring_groups.each do |spring_group|
                part2_arrangements << spring_group.arrangements.size
            end
            part2_arrangements.sum
        end
    end
end

class SpringGroup
    attr_reader :condition_records, :contiguous_groups_of_damaged_springs, :arrangements

    OPERATIONAL = '.'
    DAMAGED = '#'
    UNKNOWN = '?'

    def initialize(input, unfolded = false)
        @match_memo = {}
        split_input = input.split(' ')
        @condition_records = split_input[0]
        @contiguous_groups_of_damaged_springs = split_input[1].split(',')
        if unfolded
            # add five copies of the conditions to the end of the conditions
            @condition_records += ("?" + @condition_records) * 4
            @contiguous_groups_of_damaged_springs += @contiguous_groups_of_damaged_springs * 4
        end

        @regex = ''
        # count with index
        @contiguous_groups_of_damaged_springs.each_with_index do |count, index|
            if index == 0
                @regex += "^([.?]*[#?]{#{count}})"
            elsif index == @contiguous_groups_of_damaged_springs.length - 1
                @regex += "([.?]+[#?]{#{count}}[.?]*$)"
            else
                @regex += "([.?]+[#?]{#{count}})"
            end
        end
        @regex = Regexp.new(@regex)

        acc = []
        find_possible_arangements(@condition_records, acc, 0)
        @arrangements = acc
    end

    def find_possible_arangements(current_string, acc, position )
        if position == @condition_records.length
            acc << current_string
            return
        end
        if @condition_records[position] == UNKNOWN
            current_string[position] = OPERATIONAL
            if matches_exist?(current_string)
                find_possible_arangements(current_string.dup, acc, position + 1)
            end
            current_string[position] = DAMAGED
            if matches_exist?(current_string)
                find_possible_arangements(current_string.dup, acc, position + 1)
            end
        else
            find_possible_arangements(current_string, acc, position + 1)
        end
    end

    def matches_exist?(spring_group_string)
        return @match_memo[spring_group_string] if @match_memo.key?(spring_group_string)
        match = spring_group_string.match(@regex)
        @match_memo[spring_group_string] = match
        !match.nil?
    end

end

puts ChallengeTwelve.solutions('input_test_part1.txt')