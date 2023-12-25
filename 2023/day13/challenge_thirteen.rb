require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeThirteen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            terrains = []
            terrains_part2 = []
            input = []
            input_list.each_with_index do |line, index|
                if line == ""
                    terrains << Terrain.new(input)
                    terrains_part2 << Terrain.new(input, true)
                    input = []
                elsif index == input_list.length - 1
                    input << line
                    terrains << Terrain.new(input)
                    terrains_part2 << Terrain.new(input, true)
                    input = []
                else
                    input << line
                end
            end

            # sum the reflection numbers for all terrains
            part1 = terrains.map(&:reflection_number).sum
            part2 = terrains_part2.map(&:reflection_number).sum
            [part1, part2]
        end
    end
end

class Terrain
    attr_reader :rows, :columns, :reflection_row, :reflection_column, :reflection_number

    ASH = '.'
    ROCK = '#'

    def initialize(input_list, fix_smudge = false)
        @rows = []
        @columns = []
        input_list.each_with_index do |row, row_index|
            @rows << row
            row.each_char.with_index do |column, column_index|
                if @columns[column_index].nil?
                    @columns[column_index] = ""
                end
                @columns[column_index] << column
            end
        end
        @reflection_row = fix_smudge ? number_of_lines_behind_reflection_with_smudge(@rows) : number_of_lines_behind_reflection(@rows)
        @reflection_column = fix_smudge ? number_of_lines_behind_reflection_with_smudge(@columns): number_of_lines_behind_reflection(@columns)
        @reflection_number = @reflection_row.nil? ? @reflection_column : @reflection_row * 100
    end

    def number_of_lines_behind_reflection_with_smudge(array)
        check_back_num = 1
        found_reflection = false
        smudge_fixed = false
        lines_behind = nil
        index = 0
        while index < array.length
            line = array[index]
            if index > 0
                if found_reflection
                    check_back_num += 2
                    # if we find the smudge somewhere in the reflection, just skip the check
                    # and mark the smudge as fixed
                    if !smudge_fixed && smudge?(line, array[index - check_back_num])
                       smudge_fixed = true
                    # Reset and keep looking if 
                    # a) The line is not a smudge but truly unequal
                    # b) We've reached the end of the check without finding the smudge
                    elsif line != array[index - check_back_num] || (index - check_back_num == 0 && !smudge_fixed)
                        lines_behind = nil
                        check_back_num = 1
                        found_reflection = false
                        smudge_fixed = false
                    end
                    # if we've reached the end of the check with the smudge fixed then we're done
                    if index - check_back_num == 0 && smudge_fixed
                        break
                    end
                end
                # if we haven't found the reflection yet look for a smudged pair of lines
                if !smudge_fixed && !found_reflection && smudge?(line, array[index - check_back_num])
                    found_reflection = true
                    lines_behind = index
                    smudge_fixed = true
                    break if index == 1
                end
                # if we haven't found the reflection yet look for a pair of lines that are equal
                # except at the start or end of array since there will be no smudge found
                if line == array[index - check_back_num] && !found_reflection && index != 1 && index != array.length - 1
                    found_reflection = true
                    lines_behind = index
                end

                if line == array[index - check_back_num] && found_reflection && !smudge_fixed && index == array.length - 1
                    found_reflection = false
                    index = lines_behind  + 1
                    check_back_num = 1
                    lines_behind = nil
                end
            end
            index += 1
        end
        lines_behind
    end

    def smudge?(string1, string2)
        find_single_character_difference(string1, string2)
    end

    def find_single_character_difference(string1, string2)
        index = nil
        count = 0
        string1.each_char.with_index do |char, char_index|
            if char != string2[char_index]
                index = char_index
                count += 1
            end
        end
        index if count == 1
    end

    def number_of_lines_behind_reflection(array)
        check_back_num = 1
        found_reflection = false
        lines_behind = nil
        array.each_with_index do |line, index|
            if index > 0
                if found_reflection
                    check_back_num += 2
                    if line != array[index - check_back_num]
                        lines_behind = nil
                        check_back_num = 1
                        found_reflection = false
                    end
                    if index - check_back_num == 0
                        break
                    end
                end
                if line == array[index - check_back_num] && !found_reflection
                    found_reflection = true
                    lines_behind = index
                    break if index == 1
                end
            end
        end
        lines_behind
    end
end