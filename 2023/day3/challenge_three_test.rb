require 'minitest/autorun'
require_relative 'challenge_three'

class EngineMapTest < Minitest::Test
    def test_find_part_numbers_on_given_sample
        engine_map = [
            "467..114..",
            "...*......",
            "..35..633.",
            "......#...",
            "617*......",
            ".....+.58.",
            "..592.....",
            "......755.",
            "...$.*....",
            ".664.598.."
        ]
        part_numbers = EngineMap.find_part_numbers(engine_map)
        expected = [467, 35, 633, 617, 592, 755, 664, 598]
        assert_equal expected, part_numbers
        assert_equal 4361, part_numbers.sum
    end

    def test_find_part_numbers_on_numbers_with_adjacent_special_chars
        engine_map = [
            "467.1.....",
            ".....=..*."
        ]
        part_numbers = EngineMap.find_part_numbers(engine_map)
        expected = [1]
        assert_equal expected, part_numbers
    end

    def test_find_part_numbers_on_numbers_on_edges
        engine_map = [
            "467/1...-3",
            "9+...=..+2"
        ]
        byebug
        part_numbers = EngineMap.find_part_numbers(engine_map)
        expected = [467,1,3,9,2]
        assert_equal expected, part_numbers
    end

    def test_is_special_characters_with_special_chars
        special_chars = ["*", "@", "=", "%", "$", "+", "&", "/", "-", "#"]
        special_chars.each do |char|
            assert EngineMap.is_special_char?(char)
        end
    end

    def test_is_special_characters_with_non_special_chars
        special_chars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."]
        special_chars.each do |char|
            assert !EngineMap.is_special_char?(char)
        end
    end

end
