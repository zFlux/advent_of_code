require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeOne
    class << self
        def solutions(input_file_path)
            [solve(input_file_path, withSpelledOutNumbers = false), 
            solve(input_file_path, withSpelledOutNumbers = true)]
        end

        def solve(file_name, withSpelledOutNumbers = false)
            lines = InputFileReader.read_file_to_list(file_name)    
            numbers = lines.map do |line|
                FirstAndLastDigitNumber.find_first_and_last_digit_number(line, withSpelledOutNumbers)
            end
            numbers.sum
        end
    end
end

class FirstAndLastDigitNumber

    CONVERSION_MAP = {
        "one" => 1,
        "two" => 2,
        "three" => 3,
        "four" => 4,
        "five" => 5,
        "six" => 6,
        "seven" => 7,
        "eight" => 8,
        "nine" => 9,
        "1" => 1,
        "2" => 2,
        "3" => 3,
        "4" => 4,
        "5" => 5,
        "6" => 6,
        "7" => 7,
        "8" => 8,
        "9" => 9
    }

    class << self
        def find_first_digit(string, withSpelledOutNumbers = false)
            regex = withSpelledOutNumbers ? /(\d|one|two|three|four|five|six|seven|eight|nine)/ : /\d/
            string.scan(regex).first[0]
        end

        def find_last_digit(string, withSpelledOutNumbers = false)
            backwardsRegex = withSpelledOutNumbers ? /(\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)/ : /\d/
            string.reverse.scan(backwardsRegex).first[0].reverse
        end

        def find_first_and_last_digit_number(string, withSpelledOutNumbers = false)
            first_digit = find_first_digit(string, withSpelledOutNumbers)
            last_digit = find_last_digit(string, withSpelledOutNumbers)
            combined_digits = "#{CONVERSION_MAP[first_digit]}#{CONVERSION_MAP[last_digit]}"
            combined_digits.to_i
        end
    end      
end