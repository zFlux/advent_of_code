require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeSixteen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            room_of_lasers = RoomOfLasers.new(input_list)
            room_of_lasers.fire_laser
            part1 = room_of_lasers.count_visited_spaces
            part2 = room_of_lasers.max_visited_firing
    
            [part1,part2]
        end
    end

    class RoomOfLasers

        attr_reader :room, :laser_tracking

        EMPTY_SPACE = '.'
        MIRROR_DIAGONAL_RIGHT = '/'
        MIRROR_DIAGONAL_LEFT = '\\'
        SPLITTER_HORIZONTAL = '-'  
        SPLITTER_VERTICAL = '|'

        UP = 0
        DOWN = 1
        LEFT = 2
        RIGHT = 3

        def initialize(input_list)
            @room = create_room(input_list)
            @laser_tracking = {}
        end

        def max_visited_firing
            visited_counts = []
            start_positions = []
            @room.length.times do |row|
                start_positions << [row, @room[0].length, LEFT]
                start_positions << [row, -1, RIGHT]
            end
            @room[0].length.times do |column|
                start_positions << [-1, column, DOWN]
                start_positions << [@room.length, column, UP]
            end

            start_positions.each do |start|
                fire_laser(start)
                visited_counts << count_visited_spaces
            end
            
            visited_counts.max
        end

        def count_visited_spaces
            # for each key in laser tracking, create a copy of the key with the last element removed 
            # and put it in a set. Then return the length of the set
            @laser_tracking.keys.map do |key|
                key[0..1]
            end.to_set.length - 1
        end

        def create_room(input_list)
            # loop over the input_list and split each line into an array of characters
            # then add each array to the room array
            room = []
            input_list.each do |line|
                room << line.split('')
            end
            room
        end

        def fire_laser(start = [0,-1,RIGHT])
            @laser_tracking = {}
            active_lasers = [start]
            @laser_tracking[start] = true

            while active_lasers.length > 0
                laser = active_lasers.shift
                laser_list = move_laser(laser)
                if laser_list.empty?
                    next
                end
                laser_list.each do |laser|
                    active_lasers << laser
                end
            end
        end

        def move_laser(laser)
            row, column, direction = laser
            incr_row = direction == UP ? -1 : direction == DOWN ? 1 : 0
            incr_column = direction == LEFT ? -1 : direction == RIGHT ? 1 : 0
            
            # first move the laser
            row += incr_row
            column += incr_column

            # return nil check if the laser is out of bounds
            return [] if row < 0 || row >= @room.length || column < 0 || column >= @room[0].length

            # return nil if the laser has already occupied this space and direction
            return [] if @laser_tracking[[row, column, direction]]

            # mark the laser as having occupied this space and direction
            @laser_tracking[[row, column, direction]] = true
            
            # check if the laser is at a mirror
            if @room[row][column] == MIRROR_DIAGONAL_RIGHT
                if direction == UP
                    direction = RIGHT
                elsif direction == DOWN
                    direction = LEFT
                elsif direction == LEFT
                    direction = DOWN
                elsif direction == RIGHT
                    direction = UP
                end
            elsif @room[row][column] == MIRROR_DIAGONAL_LEFT
                if direction == UP
                    direction = LEFT
                elsif direction == DOWN
                    direction = RIGHT
                elsif direction == LEFT
                    direction = UP
                elsif direction == RIGHT
                    direction = DOWN
                end
            elsif @room[row][column] == SPLITTER_HORIZONTAL
                if direction == UP || direction == DOWN
                    direction = [LEFT, RIGHT]
                end
            elsif @room[row][column] == SPLITTER_VERTICAL
                if direction == LEFT || direction == RIGHT
                    direction = [UP, DOWN]
                end
            end

            if direction.is_a?(Array)
                direction.map do |dir| 
                    [row, column, dir]
                end
            else
                [[row, column, direction]]
            end
        end
    end
end
puts ChallengeSixteen.solutions('input.txt')