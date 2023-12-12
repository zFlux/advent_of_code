require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            pipe_map = PipeMap.new(input_list)
            path_to_the_end = pipe_map.path_to_the_end
            part_1 = path_to_the_end.length / 2
            
            part_2 = pipe_map.find_inside_loop_locations.size
            [part_1, part_2]
        end
    end
end

class PipeMap
    attr_reader :pipe_map, :start, :loop, :inside_loop, :outside_loop

    def initialize(input_list)
        inside_loop = Set.new
        outside_loop = Set.new
        # convert each line into an array of pipes
        pipe_map = []
        input_list.each_with_index do |line, row_num|
            line_list = []
            line.split('').each_with_index do |pipe, col_num|
                location = Location.new(pipe, row_num, col_num)
                @start = location if location.type == 'start'
                line_list << location
            end
            pipe_map << line_list
        end
        @pipe_map = pipe_map
    end

    def find_direction_of_travel(first_location, second_location)
        direction = ''
        if first_location.row < second_location.row
            direction = 'south'
        elsif first_location.row > second_location.row
            direction = 'north'
        elsif first_location.col < second_location.col
            direction = 'east'
        elsif first_location.col > second_location.col
            direction = 'west'
        end
        direction
    end

    def add_location(locations, row, col)
        return if row < 0 || row >= @pipe_map.length || col < 0 || col >= @pipe_map[0].length || @loop.include?(lookup(row, col))
        locations.add(lookup(row, col)) 
    end

    def find_inside_loop_locations

        right_side = Set.new
        left_side = Set.new

        # set the previous_location as the start
        previous_location = @start

        # start looping over @loop after the first location
        @loop.each_with_index do |location, index|
            next if index == 0
            current_location = location
            direction = find_direction_of_travel(previous_location, current_location)

            if direction == 'north' && current_location.type == 'vertical'
                add_location(right_side, current_location.row, current_location.col + 1)
                add_location(left_side, current_location.row, current_location.col - 1)
            elsif direction == 'south' && current_location.type == 'vertical'
                add_location(right_side, current_location.row, current_location.col - 1)
                add_location(left_side, current_location.row, current_location.col + 1)
            elsif direction == 'east' && current_location.type == 'horizontal'
                add_location(right_side, current_location.row + 1, current_location.col)
                add_location(left_side, current_location.row - 1, current_location.col)
            elsif direction == 'west' && current_location.type == 'horizontal'
                add_location(right_side, current_location.row - 1, current_location.col)
                add_location(left_side, current_location.row + 1, current_location.col)
            elsif direction == 'south' && current_location.pipe == 'L'
                add_location(right_side, current_location.row, current_location.col - 1)
                add_location(right_side, current_location.row + 1, current_location.col)
                add_location(right_side, current_location.row + 1, current_location.col - 1)
                add_location(left_side, current_location.row - 1, current_location.col + 1)
            elsif direction == 'west' && current_location.type == 'L'
                add_location(left_side, current_location.row, current_location.col - 1)
                add_location(left_side, current_location.row + 1, current_location.col)
                add_location(left_side, current_location.row + 1, current_location.col - 1)
                add_location(right_side, current_location.row - 1, current_location.col + 1)
            elsif direction == 'north' && current_location.type == '7'
                add_location(right_side, current_location.row, current_location.col + 1)
                add_location(right_side, current_location.row - 1, current_location.col)
                add_location(right_side, current_location.row - 1, current_location.col + 1)
                add_location(left_side, current_location.row - 1, current_location.col - 1)
            elsif direction == 'east' && current_location.type == '7'
                add_location(left_side, current_location.row, current_location.col + 1)
                add_location(left_side, current_location.row - 1, current_location.col)
                add_location(left_side, current_location.row - 1, current_location.col + 1)
                add_location(right_side, current_location.row - 1, current_location.col - 1)
            elsif direction == 'north' && current_location.type == 'F'
                add_location(left_side, current_location.row, current_location.col - 1)
                add_location(left_side, current_location.row - 1, current_location.col)
                add_location(left_side, current_location.row - 1, current_location.col - 1)
                add_location(right_side, current_location.row + 1, current_location.col + 1)
            elsif direction == 'west' && current_location.type == 'F'
                add_location(right_side, current_location.row, current_location.col - 1)
                add_location(right_side, current_location.row - 1, current_location.col)
                add_location(right_side, current_location.row - 1, current_location.col - 1)
                add_location(left_side, current_location.row + 1, current_location.col + 1)
            elsif direction == 'south' && current_location.type == 'J'
                add_location(left_side, current_location.row, current_location.col + 1)
                add_location(left_side, current_location.row + 1, current_location.col)
                add_location(left_side, current_location.row + 1, current_location.col + 1)
                add_location(right_side, current_location.row - 1, current_location.col - 1)
            elsif direction == 'east' && current_location.type == 'J'
                add_location(right_side, current_location.row, current_location.col + 1)
                add_location(right_side, current_location.row + 1, current_location.col)
                add_location(right_side, current_location.row + 1, current_location.col + 1)
                add_location(left_side, current_location.row - 1, current_location.col - 1)
            end
            previous_location = current_location
        end

        find_all_adjacent_locations_for_set(right_side)
        find_all_adjacent_locations_for_set(left_side)

        if contains_edges(right_side)
            right_side
        else
            left_side
        end
    end

    def contains_edges(a_set)
        # check if the set contains any locations on the edge of the map

        a_set.each do |location|
            return true if location.row == 0 || location.row == @pipe_map.length - 1 || location.col == 0 || location.col == @pipe_map[0].length - 1
        end
    end

    def find_all_adjacent_locations_for_set(a_set)
        # for each location in the set find all adjacent locations
        # not already in the set and not in the loop
        # add them to the set

        # make a copy of the set
        copy_of_a_set = a_set.clone

        copy_of_a_set.each do |location|
            adjacent_locations = add_all_adjacent_locations_for_a_location(location, a_set)
        end
    end

    def add_all_adjacent_locations_for_a_location(location, a_set)
        # don't search adjacent locations if the location is in the loop or already 
        return if @loop.include?(location)
        # add the location to the set if it's not already there
        a_set.add(location) if !a_set.include?(location)
        # find and add all adjacent locations
        adjacent_locations = []
        adjacent_locations << lookup(location.row - 1, location.col) if location.row - 1 >= 0
        adjacent_locations << lookup(location.row - 1, location.col + 1) if location.row - 1 >= 0 && location.col + 1 < @pipe_map[0].length
        adjacent_locations << lookup(location.row, location.col + 1) if location.col + 1 < @pipe_map[0].length
        adjacent_locations << lookup(location.row + 1, location.col + 1) if location.row + 1 < @pipe_map.length && location.col + 1 < @pipe_map[0].length
        adjacent_locations << lookup(location.row + 1, location.col) if location.row + 1 < @pipe_map.length
        adjacent_locations << lookup(location.row + 1, location.col - 1) if location.row + 1 < @pipe_map.length && location.col - 1 >= 0
        adjacent_locations << lookup(location.row, location.col - 1) if location.col - 1 >= 0
        adjacent_locations << lookup(location.row - 1, location.col - 1) if location.row - 1 >= 0 && location.col - 1 >= 0
        
        adjacent_locations.each do |adjacent_location|
            # don't search adjacent locations if the location is in the loop or already in the set
            add_all_adjacent_locations_for_a_location(adjacent_location, a_set) if !@loop.include?(adjacent_location) && !a_set.include?(adjacent_location)
        end
    end


    def path_to_the_end
        # start at the start
        # check if we can go north, south, east or west
        path = [@start]
        visited = Set.new
        visited.add(@start.id)
        previous_location = @start
        current_location = which_way_can_we_go_from_the_start[0]
        while !visited.include?(current_location.id)
            path << current_location
            r = current_location.row
            c = current_location.col
            visited.add(current_location.id)
            if current_location.can_go_north? && r - 1 >= 0 && lookup(r - 1, c) != previous_location
                previous_location = current_location
                current_location = lookup(r - 1, c)
            elsif current_location.can_go_south? && r + 1 < pipe_map.length && lookup(r + 1, c) != previous_location
                previous_location = current_location
                current_location = lookup(r + 1, c)
            elsif current_location.can_go_east? && c + 1 < pipe_map[0].length && lookup(r, c + 1) != previous_location
                previous_location = current_location
                current_location = lookup(r, c + 1)
            elsif current_location.can_go_west? && c - 1 >= 0 && lookup(r, c - 1) != previous_location
                previous_location = current_location
                current_location = lookup(r, c - 1)
            else
                break
            end
        end
        @loop = path
        path
    end

    def translate_start_to_pipe
        # check if we can go north, south, east or west
        north = pipe_map[@start.row - 1][@start.col] if @start.row - 1 >= 0
        south = pipe_map[@start.row + 1][@start.col] if @start.row + 1 < pipe_map.length
        east = pipe_map[@start.row][@start.col + 1] if @start.col + 1 < pipe_map[0].length
        west = pipe_map[@start.row][@start.col - 1] if @start.col - 1 >= 0
        can_go_north = north && north.can_go_south?
        can_go_south = south && south.can_go_north?
        can_go_east = east && east.can_go_west?
        can_go_west = west && west.can_go_east?

        if can_go_north && can_go_south
            Location.new('|', @start.row, @start.col)
        elsif can_go_east && can_go_west
            Location.new('-', @start.row, @start.col)
        elsif can_go_north && can_go_east
            Location.new('L', @start.row, @start.col)
        elsif can_go_north && can_go_west
            Location.new('J', @start.row, @start.col)
        elsif can_go_south && can_go_west
            Location.new('7', @start.row, @start.col)
        elsif can_go_south && can_go_east
            Location.new('F', @start.row, @start.col)
        else
            raise "Can't translate start to pipe"
        end
    end

    def which_way_can_we_go_from_the_start
        # check if we can go north, south, east or west
        north = pipe_map[@start.row - 1][@start.col] if @start.row - 1 >= 0
        south = pipe_map[@start.row + 1][@start.col] if @start.row + 1 < pipe_map.length
        east = pipe_map[@start.row][@start.col + 1] if @start.col + 1 < pipe_map[0].length
        west = pipe_map[@start.row][@start.col - 1] if @start.col - 1 >= 0
        where_can_we_go = []
        where_can_we_go << north if north && north.can_go_south?
        where_can_we_go << south if south && south.can_go_north?
        where_can_we_go << east if east && east.can_go_west?
        where_can_we_go << west if west && west.can_go_east?
        where_can_we_go
    end

    def lookup(row, col)
        @pipe_map[row][col]
    end

    def inspect
        @pipe_map.map do |line|
            line.map do |pipe|
                pipe.pipe
            end.join('')
        end
    end
end

class Location
    attr_reader :pipe, :type, :class, :id, :start, :row, :col

    PIPE_TYPES = {
        '|': 'vertical',
        '-': 'horizontal',
        'L': '90-degree-north_and_east',
        'J': '90-degree-north_and_west',
        '7': '90-degree-south_and_west',
        'F': '90-degree-south_and_east',
        '.': 'empty',
        'S': 'start'
    }

    def can_go_north?
        @type == 'vertical' || @type == '90-degree-north_and_east' || @type == '90-degree-north_and_west'
    end

    def can_go_south?
        @type == 'vertical' || @type == '90-degree-south_and_west' || @type == '90-degree-south_and_east'
    end

    def can_go_east?
        @type == 'horizontal' || @type == '90-degree-north_and_east' || @type == '90-degree-south_and_east'
    end

    def can_go_west?
        @type == 'horizontal' || @type == '90-degree-north_and_west' || @type == '90-degree-south_and_west'
    end

    GROUND_TYPE = {'.': 'ground'}
    START_TYPE = {'S': 'start'}

    # map that maps any of the pipe types to class 'pipe'
    CLASS_MAP = {
        'vertical': 'pipe',
        'horizontal': 'pipe',
        '90-degree-north_and_east': 'pipe',
        '90-degree-north_and_west': 'pipe',
        '90-degree-south_and_west': 'pipe',
        '90-degree-south_and_east': 'pipe',
        'ground': 'ground',
        'start': 'start'
    }

    def initialize(pipe, row, col)
        @row = row
        @col = col
        @id = "R#{row}C#{col}"
        @pipe = pipe
        @type = PIPE_TYPES[@pipe.to_sym] || GROUND_TYPE[@pipe.to_sym] || START_TYPE[@pipe.to_sym]
        @class = CLASS_MAP[@type.to_sym]
    end

    def inspect
        @pipe
    end

    def to_s
        @pipe
    end
end