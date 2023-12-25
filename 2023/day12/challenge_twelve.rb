require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwelve
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            # part1_possibility_counts = []
            # input_list.each do |line|
            #     part1_spring_group = SpringGroup.new(line, true)
            #     part1_arrangements = part1_spring_group.count_possible_arrangements
            #     part1_possibility_counts << part1_arrangements
            # end

            [0, 0]

            # part2_arrangements = []
            # part2_spring_groups.each do |spring_group|
            #     part2_arrangements << spring_group.arrangements.size
            # end
            # part2_arrangements.sum
        end
    end
end

class SpringGroup
    attr_reader :condition_records, :contiguous_groups_of_damaged_springs

    OPERATIONAL = '.'
    DAMAGED = '#'
    UNKNOWN = '?'

    def initialize(input, unfolded = false)
        split_input = input.split(' ')
        @condition_records = split_input[0]
        @contiguous_groups_of_damaged_springs = split_input[1].split(',')
        @contiguous_groups_of_damaged_springs.map!(&:to_i)
        if unfolded
            # add five copies of the conditions to the end of the conditions
            @condition_records += ("?" + @condition_records) * 4
            @contiguous_groups_of_damaged_springs += @contiguous_groups_of_damaged_springs * 4
        end
    end

    def count_possible_arrangements(possibility_node = nil)
        # first we need to create the initial possibility node
        # then we recursively create possibility nodes until we reach the level that is the same 
        # depth as the length of the spring group. We count how many branches make it to that level
        # and that is the number of possible arrangements
        #puts possibility_node.to_s if possibility_node

        level = 0
        damaged_group_index = 0
        damaged_counter = 0

        if !possibility_node.nil?
            level = possibility_node.level
            damaged_group_index = possibility_node.damaged_group_index
            damaged_counter = possibility_node.damaged_counter
        end

        if level == @condition_records.length && damaged_group_index >= @contiguous_groups_of_damaged_springs.length - 1 && (@contiguous_groups_of_damaged_springs[damaged_group_index].nil? || damaged_counter >= @contiguous_groups_of_damaged_springs[damaged_group_index])
            return 1
        else
            if @condition_records[level] == OPERATIONAL && can_add_operational?(level, damaged_group_index, damaged_counter)
                if last_damaged_encountered?(damaged_group_index, damaged_counter)
                    return count_possible_arrangements(PossibilityNode.new(OPERATIONAL, possibility_node, damaged_group_index + 1, 0, level + 1))
                else
                    return count_possible_arrangements(PossibilityNode.new(OPERATIONAL, possibility_node, damaged_group_index, damaged_counter, level + 1))
                end
            elsif @condition_records[level] == DAMAGED && can_add_damaged?(level, damaged_group_index, damaged_counter)
                return count_possible_arrangements(PossibilityNode.new(DAMAGED, possibility_node, damaged_group_index, damaged_counter + 1, level + 1))
            elsif @condition_records[level] == UNKNOWN
                ops = 0
                dams = 0
                if can_add_operational?(level, damaged_group_index, damaged_counter)
                    if last_damaged_encountered?(damaged_group_index, damaged_counter)
                        ops = count_possible_arrangements(PossibilityNode.new(OPERATIONAL, possibility_node, damaged_group_index + 1, 0, level + 1))
                    else
                        ops = count_possible_arrangements(PossibilityNode.new(OPERATIONAL, possibility_node, damaged_group_index, damaged_counter, level + 1))
                    end
                end
                if can_add_damaged?(level, damaged_group_index, damaged_counter)
                   dams= count_possible_arrangements(PossibilityNode.new(DAMAGED, possibility_node, damaged_group_index, damaged_counter + 1, level + 1))
                end
                return ops + dams
            end
        end
        return 0
    end

    def can_add_damaged?(level, damaged_group_index, damaged_counter)
        expected_damaged = @contiguous_groups_of_damaged_springs[damaged_group_index]
        expected_damaged && damaged_counter < expected_damaged
    end

    def can_add_operational?(level, damaged_group_index, damaged_counter)
        return true if no_damaged_encountered?(damaged_counter) && (enough_room_for_remaining_damaged?(level, damaged_group_index, damaged_counter) || all_damaged_encountered?(damaged_group_index, damaged_counter))
        return true if last_damaged_encountered?(damaged_group_index, damaged_counter)
        return false
    end

    def not_the_last_spot?(level)
        level < @condition_records.length - 1
    end

    def enough_room_for_remaining_damaged?(level, damaged_group_index, damaged_counter)
        remaining_damaged = @contiguous_groups_of_damaged_springs[damaged_group_index] ? @contiguous_groups_of_damaged_springs[damaged_group_index] - damaged_counter : 0
        remaining_damaged += @contiguous_groups_of_damaged_springs[damaged_group_index + 1..-1] ? @contiguous_groups_of_damaged_springs[damaged_group_index + 1..-1].sum : 0
        remaining_room = @condition_records.length - level
        
        remaining_groups = (damaged_group_index + 1..-1).size
        remaining_groups = remaining_groups - 1

        remaining_damaged + remaining_groups <= remaining_room
    end
    
    def all_damaged_encountered?(damaged_group_index, damaged_counter)
        damaged_group_index == @contiguous_groups_of_damaged_springs.length
    end

    def last_damaged_encountered?(damaged_group_index, damaged_counter)
        expected_damaged = @contiguous_groups_of_damaged_springs[damaged_group_index]
        expected_damaged && damaged_counter == expected_damaged
    end

    def no_damaged_encountered?(damaged_counter)
        damaged_counter == 0    
    end
end

class PossibilityNode
    attr_reader :value, :parent, :damaged_group_index, :damaged_counter, :level 
    def initialize(value, parent, damaged_group_index, damaged_counter, level)
        @value = value
        @parent = parent
        @damaged_group_index = damaged_group_index
        @damaged_counter = damaged_counter
        @level = level
    end

    def to_s
        # recurse up the tree and print the values
        if @parent.nil?
            return @value
        else
            return @parent.to_s + @value
        end
    end
end