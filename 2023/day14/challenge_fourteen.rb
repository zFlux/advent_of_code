require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeFourteen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            platform1 = Platform.new(input_list)
            platform1.tilt(Platform::NORTH)
            platform1.calculate_north_support_load

            platform2 = Platform.new(input_list)
            platform2.cycle(1000000000)       

            [platform1.north_support_load, platform2.north_support_load]
        end
    end
end

class Platform

    attr_reader :map, :north_support_load, :round_rock_locations

    ROUND_ROCK = 'O'
    SQUARE_ROCK = '#'
    EMPTY_SPACE = '.'

    NORTH = 'N'
    WEST = 'W'
    SOUTH = 'S'
    EAST = 'E'

    def initialize(input_list)
        @map = create_map(input_list)
        @rows = input_list.length
        @columns = input_list[0].length
        @north_support_load = 0
        @north_support_cycles = []

        @potential_cycles = {}
        @round_rock_locations = ""
        @round_rock_location_list = []
        cycle = []
    end

    def create_map(input_list)
        map = {}
        input_list.each_with_index do |row, row_index|
            row.each_char.with_index do |char, char_index|
                map[[row_index, char_index]] = char
            end
        end
        map
    end

    def print_map
        @rows.times do |row_index|
            @columns.times do |column_index|
                print @map[[row_index, column_index]]
            end
            puts "\n"
        end
    end

    def cycle(times)
        
        cycle = nil
        cycle_start_index = nil

        times.times do
            tilt(NORTH)
            tilt(WEST)
            tilt(SOUTH)
            tilt(EAST)
            calculate_north_support_load
            @north_support_cycles << @north_support_load
            @round_rock_location_list << @round_rock_locations
            cycle = detect_cycle
            if !cycle.nil?
                break
            end
        end

        if !cycle.nil?
            # take the original number and subtract the cycle start index
            # then take the remainder and divide by the cycle length
            # then take the remainder of that and add it to the cycle start index
            # then take the value at that index
            cycle_start_index = cycle[0]
            cycle_length = cycle[1] - cycle[0] + 1
            cycle_index = (times - cycle_start_index) % cycle_length + cycle_start_index - 1
            @north_support_load = @north_support_cycles[cycle_index]
        end
    end

    def detect_cycle
        # look for a cycle using floyd's cycle detection algorithm
        # https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_Tortoise_and_Hare
        tortoise_index = 0
        hare_index = 1
        tortoise = @round_rock_location_list[tortoise_index]
        hare = @round_rock_location_list[hare_index]
        while tortoise != hare do
            tortoise_index += 1
            hare_index += 2
            if hare_index >= @round_rock_location_list.length
                return nil
            end
            tortoise = @round_rock_location_list[tortoise_index]
            hare = @round_rock_location_list[hare_index]
        end

        [tortoise_index, hare_index - 1]
    end

    def tilt(direction)
        # When tilting north we need to start the check from the far "north" side of the map
        # i.e. 0th row and then moving upwards

        if direction == NORTH || direction == SOUTH
            start_row = direction == NORTH ? 0 : @rows
            end_row = direction == NORTH ? @rows : 0
            row_incr = direction == NORTH ? 1 : -1
            
            row_index = start_row
            while row_index != end_row + row_incr do
                @columns.times do |column_index|
                    if @map[[row_index, column_index]] == ROUND_ROCK
                        new_loc = move_round_rock(row_index, column_index, direction)
                    end
                end
                row_index += row_incr
            end
        elsif direction == EAST || direction == WEST
            start_column = direction == WEST ? 0 : @columns
            end_column = direction == WEST ? @columns : 0
            column_incr = direction == WEST ? 1 : -1

            column_index = start_column
            while column_index != end_column + column_incr do
                @rows.times do |row_index|
                    if @map[[row_index, column_index]] == ROUND_ROCK
                        new_loc = move_round_rock(row_index, column_index, direction)
                    end
                end
                column_index += column_incr
            end
        end
    end

    def calculate_north_support_load
        @north_support_load = 0
        @round_rock_locations = ""
        @rows.times do |row_index|
            @columns.times do |column_index|
                if @map[[row_index, column_index]] == ROUND_ROCK
                    @north_support_load += @rows - row_index
                    @round_rock_locations += "#{row_index},#{column_index} "
                end
            end
        end
    end

    def move_round_rock(row_index, column_index, direction)
        curr_row = row_index
        curr_column = column_index
        
        row_incr = 0
        col_incr = 0
        if direction == NORTH || direction == SOUTH
            row_incr = direction == NORTH ? -1 : 1
        end
        if direction == EAST || direction == WEST
            col_incr = direction == WEST ? -1 : 1
        end

        while curr_row > -1 && curr_column > -1
            if @map[[curr_row + row_incr, curr_column + col_incr]] == EMPTY_SPACE
                curr_row += row_incr
                curr_column += col_incr
            else
                break
            end
        end

        @map[[row_index, column_index]] = EMPTY_SPACE
        @map[[curr_row, curr_column]] = ROUND_ROCK

        [curr_row, column_index]
    end

end
puts ChallengeFourteen.solutions('input.txt')