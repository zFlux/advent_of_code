require 'minitest/autorun'
require_relative 'challenge_thirteen'

class ChallengeThirteen_Objects < Minitest::Test

    def setup
        input1 = [
            ".#######..###",
            "...##...##...",
            "###..#####...",
            "###..#####...",
            "...##...##...",
            ".#######..###",
            ".#....#.##.#."
        ]
        @terrain1 = Terrain.new(input1, true)

        input2 = [
            "#.#..##",
            "#.#.#.#",
            "...##..",
            "#..###.",
            ".#..##.",
            ".#####.",
            ".#####.",
            ".#..##.",
            "#..###.",
            "...##..",
            "#.#.#.#",
            "#.##.##",
            "#.##.##"
        ]

        @terrain2 = Terrain.new(input2, true)

        input3 = [
            "#.##.##",
            "..##.##",
            "..##.##",
            "#.##.##",
            ".#....#",
            "#.#....",
            "##.##.#",
            "..###..",
            "...###."
        ]

        @terrain3 = Terrain.new(input3, true)

        input4 = [
            ".##..##",
            "###..##",
            "#..##..",
            "#..##..",
            "##....#",
            ".##..##",
            "##.##.#",
            "###..##",
            ".##..##",
            "..#..#.",
            ".#.##.#"
        ]

        @terrain4 = Terrain.new(input4, true)

    end

    # def test_terrain_object1
    #     assert_equal 7, @terrain1.rows.length
    #     assert_equal 13, @terrain1.columns.length
    #     assert_nil @terrain1.reflection_row
    #     assert_equal 12, @terrain1.reflection_column
    #     assert_equal 12, @terrain1.reflection_number
    # end

    # def test_terrain_object2
    #     assert_equal 13, @terrain2.rows.length
    #     assert_equal 7, @terrain2.columns.length
    #     assert_equal 6, @terrain2.reflection_row
    #     assert_nil @terrain2.reflection_column
    #     assert_equal 600, @terrain2.reflection_number
    # end

    # def test_terrain_object3
    #     assert_equal 9, @terrain3.rows.length
    #     assert_equal 7, @terrain3.columns.length
    #     assert_equal 1, @terrain3.reflection_row
    #     assert_equal nil, @terrain3.reflection_column
    #     assert_equal 100, @terrain3.reflection_number
    # end

    def test_terrain_object4
        assert_equal 11, @terrain4.rows.length
        assert_equal 7, @terrain4.columns.length
        assert_equal 1, @terrain4.reflection_row
        assert_equal nil, @terrain4.reflection_column
        assert_equal 100, @terrain4.reflection_number
    end
end