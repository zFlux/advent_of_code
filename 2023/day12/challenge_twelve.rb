require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwelve
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            spring_groups = []
            input_list.each do |line|
                spring_groups << SpringGroup.new(line)
            end
            spring_group_arrangements = []
            spring_groups.each do |spring_group|
                spring_group_arrangements << spring_group.arrangements.size
            end
            spring_group_arrangements.sum
        end
    end
end

class SpringGroup
    attr_reader :condition_records, :contiguous_groups_of_damaged_springs, :arrangements

    OPERATIONAL = '.'
    DAMAGED = '#'
    UNKNOWN = '?'

    def initialize(input)
        split_input = input.split(' ')
        @condition_records = split_input[0]
        @contiguous_groups_of_damaged_springs = split_input[1].split(',')
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
            string_with_operational = current_string.dup
            string_with_operational[position] = OPERATIONAL
            string_with_damaged = current_string.dup
            string_with_damaged[position] = DAMAGED
            if matches_exist?(string_with_operational)
                find_possible_arangements(string_with_operational, acc, position + 1)
            end
            if matches_exist?(string_with_damaged)
                find_possible_arangements(string_with_damaged, acc, position + 1)
            end
        else
            find_possible_arangements(current_string, acc, position + 1)
        end
    end

    def matches_exist?(spring_group_string)
        match = spring_group_string.match(@regex)
        !match.nil?
    end

end

puts ChallengeTwelve.solutions('input.txt')