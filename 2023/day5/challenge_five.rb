require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeFive
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
        end
    end
end