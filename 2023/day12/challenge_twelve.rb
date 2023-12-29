require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwelve
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            spring_groups_part1 = []
            spring_groups_part2 = []
            all_spring_groups_part1 = []
            input_list.each do |line|
                spring_group_part1 = SpringGroup.new(line)
                spring_group_part2 = SpringGroup.new(line, true)
                spring_groups_part1 << spring_group_part1.possible_combinations
                spring_groups_part2 << spring_group_part2.possible_combinations
                all_spring_groups_part1 << spring_group_part1
            end
            [spring_groups_part1.sum, spring_groups_part2.sum]
        end
    end
end

class SpringGroup
    attr_reader :condition_records, :group_records, :counts

    OPERATIONAL = '.'
    DAMAGED = '#'
    UNKNOWN = '?'

    def initialize(input, unfolded = false)
        split_input = input.split(' ')
        @condition_records = split_input[0]
        @group_records = split_input[1].split(',')
        @group_records.map!(&:to_i)
        if unfolded
            @condition_records += ("?" + @condition_records) * 4
            @group_records += @group_records * 4
        end
        @counts = {}
    end

    # How this will work:
    # 1. If the group is going to pass a damaged location or the group reaches its farthest possible point - i.e. 
    #    the group is at the end of the condition records minus the minimum space required to fit all remaining groups
    #    then there's nothing to count so return 0
    # 2. Starting with the first group, check if the group fits at the start location of the condition records
    #    a. if the group fits and there are no other groups (check for any remaining #'s) then add 1 to a count
    #    b. if the group fits and there is another group after it , then set the count equal to the recursive result of counting 
    #       possibilities for the next group starting at the first possible position for the next group 
    #       (instead of the start location)
    # 3. Regardless of whether the current group fits or has possibilities at current location, add to count
    #    the recursive result of counting possibilities for the current group starting at the next location
    # 4. At the end of the recursive call store the count in a cache
    # 5. At the beginning of the recursive call check the cache for the count and return it if it exists

    
    def possible_combinations(search_index = 0, group_index = 0)

        group_size = @group_records[group_index]
        if (search_index > 0 && @condition_records[search_index - 1] == DAMAGED) || 
            search_index + group_size + min_space_required_for(group_index + 1) >= @condition_records.size
            return 0
        end

        if @counts["#{group_index},#{search_index}"]
            return @counts["#{group_index},#{search_index}"]
        end

        count = 0
        group_size = @group_records[group_index]
        if can_contain_group(@condition_records[search_index..(search_index + group_size)], group_size)
            if group_index == @group_records.size - 1
                remaining_condition_records = @condition_records[(search_index + group_size)..-1]
                count += 1 if remaining_condition_records.nil? || remaining_condition_records.index(DAMAGED).nil?
            else
                count = possible_combinations(search_index + group_size + 1, group_index + 1)
            end
        end

        count += possible_combinations(search_index + 1, group_index)
        @counts["#{group_index},#{search_index}"] = count
        count
    end

    def min_space_required_for(group_index)
        space = 0
        group_index.upto(@group_records.size - 1) do |index|
            space += @group_records[index] + 1
        end
        space - 1
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