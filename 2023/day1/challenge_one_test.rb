require 'minitest/autorun'
require_relative 'challenge_one'

class FirstAndLastDigitNumberTest < Minitest::Test
    def test_find_first_digit
        assert_equal '1', FirstAndLastDigitNumber.find_first_digit('123')
        assert_equal '8', FirstAndLastDigitNumber.find_first_digit('axnine87ninexx')
        assert_equal '5', FirstAndLastDigitNumber.find_first_digit('anc56five7')
        assert_equal '1', FirstAndLastDigitNumber.find_first_digit('123', true)
        assert_equal 'nine', FirstAndLastDigitNumber.find_first_digit('axnine87ninexx', true)
        assert_equal 'six', FirstAndLastDigitNumber.find_first_digit('ancsixeseven56five7', true)
    end

    def test_find_last_digit
        assert_equal '3', FirstAndLastDigitNumber.find_last_digit('123')
        assert_equal '7', FirstAndLastDigitNumber.find_last_digit('987')
        assert_equal '1', FirstAndLastDigitNumber.find_last_digit('561')
        assert_equal 'four', FirstAndLastDigitNumber.find_last_digit('123fourxfd', true)
        assert_equal 'seven', FirstAndLastDigitNumber.find_last_digit('987sixseven', true)
        assert_equal 'three', FirstAndLastDigitNumber.find_last_digit('5two61three', true)
    end

    def test_find_first_and_last_digit_number
        assert_equal 13, FirstAndLastDigitNumber.find_first_and_last_digit_number('123seven')
        assert_equal 97, FirstAndLastDigitNumber.find_first_and_last_digit_number('two987')
        assert_equal 57, FirstAndLastDigitNumber.find_first_and_last_digit_number('567eight')
        assert_equal 17, FirstAndLastDigitNumber.find_first_and_last_digit_number('123seven', true)
        assert_equal 27, FirstAndLastDigitNumber.find_first_and_last_digit_number('two987', true)
        assert_equal 58, FirstAndLastDigitNumber.find_first_and_last_digit_number('567eight', true)
        assert_equal 18, FirstAndLastDigitNumber.find_first_and_last_digit_number('oneight', true)
    end

    def test_solve_part_one
        file_path = "input_test_part1.txt"
        assert_equal 142, ChallengeOne.solve(file_path, true)
    end

    def test_solve_part_two
        file_path = "input_test_part2.txt"
        assert_equal 281, ChallengeOne.solve(file_path, true)
    end
end