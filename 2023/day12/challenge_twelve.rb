require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwelve
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            spring_groups_part1 = []
            #spring_groups_part2 = []
            input_list.each do |line|
                spring_group_part1 = SpringGroup.new(line)
               # spring_group_part2 = SpringGroup.new(line, true)
                spring_groups_part1 << spring_group_part1.count_of_possibilities
               # spring_groups_part2 << spring_group_part2.count_of_possibilities
            end
            #byebug
            [spring_groups_part1.sum, 0]
        end
    end
end

class SpringGroup
    attr_reader :condition_records, :count_records, :group_start_positions, :counts, :count_of_possibilities

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
        @count_of_possibilities = @counts[0].values.sum
        # sum the counts of the first group

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

                # Figuring out the counts starts here

                # if we are on the last group then mark a count of 1 in any location that can fit that group
                # beyond the search index
                if group_index == @count_records.length - 1
                    search_index.upto(@condition_records.length - group_size) do |index|
                        if index > 0 && condition_records[index - 1] == DAMAGED
                            break
                        end
                        if can_contain_group(@condition_records[index..(index + group_size)], group_size)
                            @counts[group_index] ||= {}
                            @counts[group_index][index] = 1
                        end
                    end
                else
                    # otherwise sum the counts of the prior group where the indexes come after the end of where
                    # the current group ends. i.e. if the current group ends at index 7, then sum the counts from 
                    # index 8 to the end of the string. If the current group ends at index 8, then sum the counts
                    # from index 9 to the end of the string etc.
                    #
                    # The loop of on the current group starts at search index and ends at the position before the
                    # last possible group position of the previous group (i.e. the last possible group position of
                    # the previous group is the end of the string minus the size of the previous group minus 1)

                   # byebug if group_index == 0
                    # get the last index of the previous group from @counts
                    last_index_of_previous_group = @counts[group_index + 1].keys.max
                    search_index.upto(last_index_of_previous_group) do |index|
                        if index > 0 && condition_records[index - 1] == DAMAGED
                            break
                        end
                        if can_contain_group(@condition_records[index..(index + group_size)], group_size)
                            #sum the counts of the prior group as long as the index is after the current index + group size
                            @counts[group_index + 1].each do |key, value|
                                if key >= index + group_size + 1
                                    @counts[group_index] ||= {}
                                    @counts[group_index][index] = @counts[group_index][index].to_i + value
                                end
                            end
                            
                        end
                    end

                    # Figuring out the counts ends here
                end

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

puts ChallengeTwelve.solutions('input.txt')