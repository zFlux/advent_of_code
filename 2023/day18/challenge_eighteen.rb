require 'byebug'
require 'pqueue'
require 'multi_range'
require_relative '../lib/input_file_reader'

class ChallengeEighteen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            lagoon_part1 = Lagoon.new(input_list, false)
            lagoon_part2 = Lagoon.new(input_list, true)

            [lagoon_part1.trench_locations, lagoon_part2.trench_locations]
        end
    end
end

class Lagoon
    attr_reader :map, :trench_locations

    RIGHT = 'R'
    LEFT = 'L'
    UP = 'U'
    DOWN = 'D'

    DIRECTION_INCREMENT_MAP = {
        UP => [0,-1],
        DOWN => [0,1],
        RIGHT => [1,0],
        LEFT => [-1,0]
    }
    
    INSIDE_DIRECTION_MAP = {
        UP => DOWN,
        DOWN => UP,
        RIGHT => DOWN,
        LEFT => UP
    }

    def initialize(input_list, part2 = false)
        @area_ranges_right_to_left = {}
        @area_ranges_left_to_right = {}
        @border_ranges = []

        @instruction_list = create_instructions(input_list, part2)
        execute_instructions

        @trench_locations = 0
        @border_ranges.each do |range|
            @trench_locations += (range[1] - range[0]).abs + 1
        end
        @trench_locations += count_interior
    end

    def count_interior
        interior_count = 0
        
        left_to_right = @area_ranges_left_to_right.sort 
        left_to_right.each do |left_ranges|
            row = left_ranges[0]
            left_ranges[1].each do |left_range|
                interior_count += compute_area_for_left_range(row, left_range)
            end
        end

        interior_count
    end

    def compute_area_for_left_range(row, range)
        area = 0
        curr_range = range
        right_to_left = @area_ranges_right_to_left.sort

        right_to_left.each do |match_ranges|
            match_row = match_ranges[0]
            next if match_row <= row

            depth = match_row - row - 1

            match_ranges[1].each do |match_range|
                # if the match range is completely 
                # outside the range then skip it
                next if !curr_range.overlaps?(match_range)
                overlap = curr_range & match_range
                difference = curr_range - match_range
                area += (overlap.size * depth) 
                curr_range = difference
            end
        end

        return area
    end

    def create_instructions(input_list, part2 = false)
        instructions = []
        input_list.each do |input|
            instructions << Instruction.new(input, part2)
        end
        instructions
    end

    def execute_instructions
        curr_x = 0
        curr_y = 0
        # look at three instructions at a time. The current instruction
        # the previous instruction and the next instruction
        @instruction_list.each_with_index do |instruction, index|
            previous_direction = @instruction_list[index - 1].direction
            curr_direction = instruction.direction
            # if the index is out of bounds then the next direction is the first direction
            if index == @instruction_list.length - 1
                next_direction = @instruction_list[0].direction
            else
                next_direction = @instruction_list[index + 1].direction
            end

            incr_x, incr_y = DIRECTION_INCREMENT_MAP[instruction.direction]
            new_x = curr_x + incr_x * instruction.distance
            new_y = curr_y + incr_y * instruction.distance
            if new_x > curr_x
                mod_left_x = previous_direction == UP ? curr_x + 1 : curr_x
                mod_right_x = next_direction == DOWN ? new_x - 1 : new_x
                @area_ranges_left_to_right[curr_y] = [] if @area_ranges_left_to_right[curr_y].nil?
                @area_ranges_left_to_right[curr_y] << MultiRange.new([mod_left_x..mod_right_x])
                @border_ranges << [curr_x, new_x - 1, "L"]
            elsif new_x < curr_x
                mod_left_x = next_direction == UP ? new_x + 1 : new_x
                mod_right_x = previous_direction == DOWN ? curr_x - 1 : curr_x
                @area_ranges_right_to_left[curr_y] = [] if @area_ranges_right_to_left[curr_y].nil?
                @area_ranges_right_to_left[curr_y] << MultiRange.new([mod_left_x..mod_right_x])
                @border_ranges << [new_x, curr_x - 1, "R"]
            elsif new_y > curr_y
                @border_ranges << [curr_y, new_y - 1, "D"]
            elsif new_y < curr_y
                @border_ranges << [new_y, curr_y - 1, "U"]
            end

            curr_x = new_x
            curr_y = new_y
        end
    end
end

class Instruction

    attr_reader :direction, :distance, :colour

    DIRECTION_MAP = {
        0 => 'R',
        1 => 'D',
        2 => 'L',
        3 => 'U'
    }

    def initialize(input, part2 = false)
        # parse an instruction that looks like this: R 5 (#58a492)
        split_input = input.split(' ')
        @direction = split_input[0]
        @distance = split_input[1].to_i
        # remove the brackets from the colour
        @colour = split_input[2][2..-2]

        if part2
            first_five = @colour[0..4]
            last_digit = @colour[-1]
            # read the first five digits as a hexadecimal number
            @distance = first_five.to_i(16)
            # read the last digit as a hexadecimal number
            @direction = DIRECTION_MAP[last_digit.to_i(16)]
        end

    end
end

puts ChallengeEighteen.solutions('input.txt')