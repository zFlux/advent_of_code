require 'minitest/autorun'
require_relative 'challenge_twelve'

class ChallengeTwelve_Objects < Minitest::Test

    # test initializing a SpringGroup
    def test_initialize_spring_group
        input = "?###??????????###??????????###??????????###??????????###???????? 3,2,1,3,2,1,3,2,1,3,2,1,3,2,1"
        spring_group = SpringGroup.new(input)
        assert_equal "?###??????????###??????????###??????????###??????????###????????", spring_group.condition_records
        assert_equal [3,2,1,3,2,1,3,2,1,3,2,1,3,2,1], spring_group.count_records
    end

    # ?###??????????###??????????###??????????###??????????###????????
    #
    # expected first positions
    # .###.##.#.....###.##.#.....###.##.#.....###.##.#.....###.##.#...
    # 1,5,8,14,18,21,27,31,34,40,44,47,53,57,60

    # test finding the first group positions
    def test_find_first_group_positions
        input = "?###??????????###??????????###??????????###??????????###???????? 3,2,1,3,2,1,3,2,1,3,2,1,3,2,1"
        spring_group = SpringGroup.new(input)
        assert_equal [1, 5, 8, 14, 18, 21, 27, 31, 34, 40, 44, 47, 53, 57, 60], spring_group.group_start_positions
    end

    # Do this brute force:
    # 1) Try the first spring group at the first position and check that conditions are met
    # i.e. there are 3 wildcards or hashes with a wildcard or dot available for a space
    #   a) If the conditions are met, recurse on to the next spring group, starting at where
    #   the first spring group ended
    #   b) If the conditions are not met then move the first spring group to the next position
    #   and try again
    # 2) If you've run out of spring groups to recurse on then simply return true
    #

    # test various other spring groups
    def test_find_first_group_positions_2
        input = "?###???????? 3,2,1"
        spring_group = SpringGroup.new(input, true)
        assert_equal [1, 5, 8, 14, 18, 21, 27, 31, 34, 40, 44, 47, 53, 57, 60], spring_group.group_start_positions
    end

    def test_find_first_group_positions_3
        input = "???.### 1,1,3"
        spring_group = SpringGroup.new(input)
        assert_equal [0, 2, 4], spring_group.group_start_positions
    end

    def test_find_first_group_positions_4
        input = ".??..??...?##. 1,1,3"
        spring_group = SpringGroup.new(input)
        assert_equal [1, 5, 10], spring_group.group_start_positions
    end

    def test_find_first_group_positions_5
        input = "?#?#?#?#?#?#?#? 1,3,1,6"
        #        .#.###.#.######
        spring_group = SpringGroup.new(input)
        assert_equal [1, 3, 7, 9], spring_group.group_start_positions
    end

    def test_find_first_group_positions_6
        input = "????.#...#... 4,1,1"
        spring_group = SpringGroup.new(input)
        assert_equal [0, 5, 9], spring_group.group_start_positions
    end

    def test_find_first_group_positions_7
        input = "????.######..#####. 1,6,5"
        spring_group = SpringGroup.new(input)
        assert_equal [0, 5, 13], spring_group.group_start_positions
    end
    
end
