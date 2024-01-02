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

            lens_boxes = LensBoxes.new
            input_list.each do |input|
                lens_boxes.execute_operation(input)
            end

            part2_sum = lens_boxes.focusing_power
    
            [part1_sum,part2_sum ]
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

    class Lens
        attr_reader :label, :box, :focal_length 

        def initialize(label, focal_length = nil)
            @label = label
            hashed_label = HashedString.new(label)
            @box = hashed_label.hash_value
            @focal_length = focal_length
        end
    end

    class LensBoxes
        attr_reader :lens_boxes

        ADD_OPERATION = '='
        REMOVE_OPERATION = '-'

        def initialize
            @lens_boxes = []
        end

        def execute_operation(lens_and_operation)
            lens, operation = parse_lens_and_operation(lens_and_operation)
            box = lens.box
            if operation == ADD_OPERATION
                if !@lens_boxes[box]
                    @lens_boxes[box] = []
                end

                label_index = index_of_label(box, lens.label)
                if label_index.nil?
                    @lens_boxes[box].push(lens)
                else
                    @lens_boxes[box][label_index] = lens
                end
            else
                label_index = index_of_label(box, lens.label)
                @lens_boxes[box].delete_at(label_index) if !label_index.nil?
            end
        end

        def index_of_label(box, label)
            return nil if !@lens_boxes[box]
            @lens_boxes[box].each_with_index do |lens, index|
                if lens.label == label
                    return index
                end
            end
            nil
        end

        def parse_lens_and_operation(lens_and_operation)
            result = lens_and_operation.split('=')
            if result.length == 2
                lens = Lens.new(result[0], result[1])
                operation = ADD_OPERATION
            else
                result = lens_and_operation.split('-')
                lens = Lens.new(result[0])
                operation = REMOVE_OPERATION
            end
            [lens, operation]
        end

        def inspect
            @lens_boxes.each_with_index do |box, index|
                if !box.nil?
                    puts "Box #{index}:"
                    box.each do |lens|
                        puts " [ #{lens.label} #{lens.focal_length} ] "
                    end
                end
            end
        end

        def focusing_power
            focusing_power = 0
            @lens_boxes.each_with_index do |box, index|
                if !box.nil? && box.length > 0
                    box_val = index + 1
                    box.each_with_index do |lens, lens_index|
                        slot = lens_index + 1
                        lens_power = box_val * slot * lens.focal_length.to_i
                        focusing_power += lens_power
                    end
                end
            end
            focusing_power
        end

    end

end
puts ChallengeFifteen.solutions('input.txt')