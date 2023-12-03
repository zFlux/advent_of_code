require 'minitest/autorun'
require_relative 'challenge_two'

class ChallengeTwoTest < Minitest::Test

    def test_powers_of_minimum_games
        maximums_of_each_cube_game = [{ red: 2, green: 3, blue: 4 }, { red: 1, green: 2, blue: 3 }]
        maximums_allowed = { red: 12, green: 13, blue: 14 }
        expected_game_powers = [24, 6]

        game_powers = ChallengeTwo.powers_of_minimum_games(maximums_of_each_cube_game, maximums_allowed)

        assert_equal expected_game_powers, game_powers
    end

    def test_game_indexes_under_maximums
        maximums_of_each_cube_game = [{ red: 2, green: 3, blue: 4 }, { red: 1, green: 2, blue: 3 }, { red: 13, green: 2, blue: 3 }]
        maximums_allowed = { red: 12, green: 13, blue: 14 }
        expected_games_under_maximums = [1, 2]

        games_under_maximums = ChallengeTwo.game_indexes_under_maximums(maximums_of_each_cube_game, maximums_allowed)

        assert_equal expected_games_under_maximums, games_under_maximums
    end

    def test_maximum_values
        line = "Game 8: 13 green; 5 green; 3 blue, 9 green, 1 red; 4 red, 11 green, 4 blue"
        expected_maximums = { red: 4, green: 13, blue: 4 }

        maximums = ColourCubeGameParser.maximum_values(line)

        assert_equal expected_maximums, maximums
    end
end