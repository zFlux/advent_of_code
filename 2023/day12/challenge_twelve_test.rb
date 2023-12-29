require 'minitest/autorun'
require_relative 'challenge_twelve'

class ChallengeTwelve_Objects < Minitest::Test

    # # test initializing a SpringGroup
    def test_initialize_spring_group
        input = "?###??????????###??????????###??????????###??????????###???????? 3,2,1,3,2,1,3,2,1,3,2,1,3,2,1"
        spring_group = SpringGroup.new(input)
        assert_equal "?###??????????###??????????###??????????###??????????###????????", spring_group.condition_records
        assert_equal [3,2,1,3,2,1,3,2,1,3,2,1,3,2,1], spring_group.group_records
    end

    def test_find_counts_1
        input = "???.### 1,1,3"
        spring_group = SpringGroup.new(input)
        assert_equal 1, spring_group.possible_combinations
    end

    def test_find_counts_2
        input = ".??..??...?##. 1,1,3"
        spring_group = SpringGroup.new(input)
        assert_equal 4, spring_group.possible_combinations
    end

    def test_find_counts_3
        input = "?#?#?#?#?#?#?#? 1,3,1,6"
        spring_group = SpringGroup.new(input)
        assert_equal 1, spring_group.possible_combinations
    end

    def test_find_counts_4
        input = "????.#...#... 4,1,1"
        spring_group = SpringGroup.new(input)
        assert_equal 1, spring_group.possible_combinations
    end

    def test_find_counts_5
        input = "????.######..#####. 1,6,5"
        spring_group = SpringGroup.new(input)
        assert_equal 4, spring_group.possible_combinations
    end

    def test_find_counts_6
        input = "?###???????? 3,2,1"
        spring_group = SpringGroup.new(input)
        assert_equal 10, spring_group.possible_combinations
    end

    def test_find_counts_7
        input = "???????????? 3,2,1"
        spring_group = SpringGroup.new(input)
        assert_equal 35, spring_group.possible_combinations
    end

    def test_find_counts_8
        input = "?.???????.. 4,1"
        # ?.???????..
        # ..####.#...
        # ..####..#..
        # ...####.#..

        spring_group = SpringGroup.new(input)
        assert_equal 3, spring_group.possible_combinations
    end

    def test_find_counts_9
        input = ".????#??##?#.????? 1,3,3,1,1,1"
        # .????#??##?#.?????
        # .#.###.###.#.#.#..
        # .#.###.###.#.#..#.
        # .#.###.###.#.#...#
        # .#.###.###.#..#.#.
        # .#.###.###.#..#..#
        # .#.###.###.#...#.#

        spring_group = SpringGroup.new(input)
        assert_equal 6, spring_group.possible_combinations
    end

    def test_find_counts_10
        input = "?##..??.#.?????? 2,1,1,4"
        # ?##..??.#.??????
        # .##..#..#.####..
        # .##..#..#..####.
        # .##..#..#...####
        # .##...#.#.####..
        # .##...#.#..####.
        # .##...#.#...####
        # .##.....#.#.####
        spring_group = SpringGroup.new(input)
        assert_equal 7, spring_group.possible_combinations
    end

    def test_find_counts_11
        input = "#?????????#???? 1,3,2,2"
        # #?????????#????
        # #.###.##.##....
        # #.###.##..##...
        # #.###..##.##...
        # #.###....##.##.
        # #.###....##..##
        # #.###.....##.##
        # #..###.##.##...
        # #..###...##.##.
        # #..###...##..##
        # #..###....##.##
        # #...###..##.##.
        # #...###..##..##
        # #...###...##.##
        # #....###.##.##.
        # #....###.##..##
        # #....###..##.##
        # #.....###.##.##
        spring_group = SpringGroup.new(input)
        assert_equal 17, spring_group.possible_combinations
    end

    # # Unfolded tests

    def test_find_counts_unfolded_1
        input = "???.### 1,1,3"
        spring_group = SpringGroup.new(input, true)
        assert_equal 1, spring_group.possible_combinations
    end

    def test_find_counts_unfolded_2
        input = ".??..??...?##. 1,1,3"
        spring_group = SpringGroup.new(input, true)
        assert_equal 16384, spring_group.possible_combinations
    end

    def test_find_counts_unfolded_3
        input = "?#?#?#?#?#?#?#? 1,3,1,6"
        spring_group = SpringGroup.new(input, true)
        assert_equal 1, spring_group.possible_combinations
    end

    def test_find_counts_unfolded_4
        input = "????.#...#... 4,1,1"
        spring_group = SpringGroup.new(input, true)
        assert_equal 16, spring_group.possible_combinations
    end

    def test_find_counts__unfolded_5
        input = "????.######..#####. 1,6,5"
        spring_group = SpringGroup.new(input, true)
        assert_equal 2500, spring_group.possible_combinations
    end

    def test_find_counts_unfolded_6
        input = "?###???????? 3,2,1"
        spring_group = SpringGroup.new(input, true)
        assert_equal 506250, spring_group.possible_combinations
    end

    # breaking tests
    def test_breaking_test_1
        input = "?#.????#????.????# 1,6,1,2"
        # ?#.????#????.????#
        # .#.######.#.....##
        # .#.######..#....##
        # .#.######....#..##
        # .#.######.....#.##
        # .#..######.#....##
        # .#..######...#..##
        # .#..######....#.##
        # .#...######..#..##
        # .#...######...#.##
        # .#....######.#..##
        # .#....######..#.##
        spring_group = SpringGroup.new(input)
        assert_equal 11, spring_group.possible_combinations
    end
end
