require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwo
    class << self
        def solutions(input_file_path)
            solve(input_file_path, { red: 12, green: 13, blue: 14 })
        end

        def solve(file_name, maximums)
            lines = InputFileReader.read_file_to_list(file_name)
            games_under_maximums = []
            games_powers = []
            lines.each_with_index.map do |line, index|
                cube_game_maxes = parse_cube_game_maximum_values(line)
                if game_maximums_under_maximums?(cube_game_maxes, maximums)
                    games_under_maximums << index + 1
                end
                games_powers << cube_game_maxes.values.reduce(:*)
            end
            [games_under_maximums.sum, games_powers.sum]
        end

        def game_maximums_under_maximums?(cube_game_maximums, maximums)
            cube_game_maximums[:red] <= maximums[:red] && 
            cube_game_maximums[:green] <= maximums[:green] && 
            cube_game_maximums[:blue] <= maximums[:blue]
        end

        def parse_cube_game_maximum_values(line)
            max_values = {}
            game_parts = line.split(":")
            game_round_strings = game_parts[1].split(";")
            game_rounds = game_round_strings.map do |game_round_string|
                round = parse_game_round(game_round_string.strip)
                round.each do |part|
                    max = max_values[part[:cube_colour].to_sym] ? max_values[part[:cube_colour].to_sym] : 0
                    max_values[part[:cube_colour].to_sym] = [part[:number_of_cubes], max].max
                end
            end
            max_values
        end

        def parse_game_round(game_round_string)
            game_round_string.split(",").map do |game_round_part|
                parse_game_round_part(game_round_part)
            end
        end

        def parse_game_round_part(game_round_part)
            game_round_part_parts = game_round_part.split(" ")
            number_of_cubes = game_round_part_parts[0].to_i
            cube_colour = game_round_part_parts[1]
            {number_of_cubes: number_of_cubes, cube_colour: cube_colour}
        end
    end
end