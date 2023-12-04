require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeThree
    class << self
        def solutions(input_file_path)
            engine_map = InputFileReader.read_file_to_list(input_file_path)
            part_numbers = EngineMap.find_part_numbers(engine_map)
            part_numbers.sum
        end
    end
end

class EngineMap
    class << self
        
        def find_part_numbers(engine_map)
            part_numbers = []
            engine_map.each_with_index.map do |line, row|
                accl = ""
                line.split("").each_with_index.map do |char, col|
                    # if the current character is not a number
                    if is_not_number?(char)
                        # but the previous character is a number
                        if !accl.empty?
                            # pass the accumulated number and the current row and col to check
                            # if there are any adjacent special characters
                            if adjacent_special_chars?(engine_map, accl, row, col)
                                part_numbers << accl.to_i
                            end
                            # reset the accumulator
                            accl = ""
                        end
                    # if we've hit the end of the line and the current character is a number
                    elsif (is_number?(char) && col == line.size - 1)
                        accl += char
                        if adjacent_special_chars?(engine_map, accl, row, col + 1)
                            part_numbers << accl.to_i
                        end
                    else
                        # if the current character is a number, accumulate it
                        accl += char
                    end
                end
            end
            part_numbers
        end

        def adjacent_special_chars?(map, number, row, col)
            # find the top left corner adjacent to the current number
            num_size = number.size
            top_left_col = col - (num_size + 1)
            top_left_row = row - 1

            curr_row = top_left_row
            curr_col = top_left_col

            has_special_char = false
            
            # iterate from the top left column to col
            while curr_col <= col
                # if the current col is equal to first or last col 
                # then check all three rows
                if curr_col == top_left_col || curr_col == col
                    has_special_char = has_special_char || is_special_char_at?(map, curr_row, curr_col) || is_special_char_at?(map, curr_row + 1, curr_col) || is_special_char_at?(map, curr_row + 2, curr_col)
                else
                    # else check only the first and last row
                    has_special_char = has_special_char || is_special_char_at?(map, curr_row, curr_col) || is_special_char_at?(map, curr_row + 2, curr_col)
                end
                curr_col += 1
            end
            has_special_char
        end

        def is_special_char_at?(map, row, col)
            if row < 0 || col < 0 || row >= map.size || col >= map[row].size
                return false
            end
            char = map[row][col]
            return is_special_char?(char)
        end

        def is_special_char?(char)
            is_not_number?(char) && !is_blank_character?(char)
        end

        def is_not_number?(char)
            !is_number?(char)
        end
        
        def is_number?(char)
            char.to_i.to_s == char
        end

        def is_blank_character?(char)
            char == '.' || char == ' ' || char == "\n"
        end

    end

end

puts ChallengeThree.solutions("input.txt")