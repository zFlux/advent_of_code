require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeThirteen
    def solutions(input_file_path)
        input_list = InputFileReader.read_file_to_list(input_file_path)

        terrains = []
        input = []
        input_list.each_with_index do |line, index|
            if line == "" || index == input_list.length - 1
                terrains << Terrain.new(input)
                input = []
            else
                input << line
            end
        end

        # sum the reflection numbers for all terrains
        part1 = terrains.map(&:reflection_number).sum
        part1
    end
end

class Terrain
    attr_reader :rows, :columns, :reflection_row, :reflection_column, :reflection_number

    ASH = '.'
    ROCK = '#'

    def initialize(input_list)
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
        @reflection_row = number_of_lines_behind_reflection(@rows)
        @reflection_column = number_of_lines_behind_reflection(@columns)
        byebug if @reflection_row.nil? && @reflection_column.nil?
        @reflection_number = @reflection_row.nil? ? @reflection_column : @reflection_row * 100
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

challenge_thirteen = ChallengeThirteen.new
puts challenge_thirteen.solutions('input.txt')