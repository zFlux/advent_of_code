require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeFifteen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)[0].split(',')
            part1_sum = 0
            input_list.each do |input|
                part1_sum += HashedString.new(input).hash_value
            end
    
            [part1_sum,0]
        end
    end

    class HashedString
        attr_reader :hash_value

        def initialize(input_string)
            @hash_value = 0
            input_string.each_char do |char|
                ascii_value = char.ord
                @hash_value += ascii_value
                @hash_value *= 17
                @hash_value = @hash_value % 256
            end
        end
    end

end
puts ChallengeFifteen.solutions('input.txt')