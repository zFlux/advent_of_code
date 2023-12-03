require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwo
    class << self
        def solutions(input_file_path)
            maximums_of_each_cube_game = ColourCubeGameParser.maximums_of_each_cube_game(input_file_path)
            maximums_allowed = { red: 12, green: 13, blue: 14 }

            part1_answer = game_indexes_under_maximums(maximums_of_each_cube_game, maximums_allowed).sum
            part2_answer = powers_of_minimum_games(maximums_of_each_cube_game, maximums_allowed).sum
            
            [part1_answer, part2_answer]
        end

        def powers_of_minimum_games(maximums_of_each_cube_game, maximums)
            game_powers = []
            maximums_of_each_cube_game.map do |cube_game_maximums|
                game_powers << cube_game_maximums.values.reduce(:*)
            end
            game_powers
        end

        def game_indexes_under_maximums(maximums_of_each_cube_game, maximums)
            games_under_maximums = []
            maximums_of_each_cube_game.each_with_index.map do |cube_game_maximums, index|
                if ColourCubeGameParser.game_maximums_under_maximums?(cube_game_maximums, maximums)
                    games_under_maximums << index + 1
                end
            end
            games_under_maximums
        end
    end
end

class ColourCubeGameParser
    class << self

        def maximums_of_each_cube_game(file_name)
            maximums_of_each_cube_game = []
            lines = InputFileReader.read_file_to_list(file_name)
            lines.map do |line|
                maximums_of_each_cube_game << maximum_values(line)
            end
            maximums_of_each_cube_game
        end

        def maximum_values(line)
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

        def game_maximums_under_maximums?(cube_game_maximums, maximums)
            cube_game_maximums[:red] <= maximums[:red] && 
            cube_game_maximums[:green] <= maximums[:green] && 
            cube_game_maximums[:blue] <= maximums[:blue]
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