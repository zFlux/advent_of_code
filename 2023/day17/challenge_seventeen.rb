require 'byebug'
require 'pqueue'
require_relative '../lib/input_file_reader'

class ChallengeSeventeen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            city_blocks = CityBlocks.new(input_list)
            [city_blocks.final_vertex[:priority],0]
        end
    end

    class CityBlocks
        attr_reader :city_blocks, :city_block_edges, :final_vertex

        NORTH = 'N'
        SOUTH = 'S'
        EAST = 'E'
        WEST = 'W'

        def initialize(input_list)
            @city_blocks = []
            input_list.each do |input|
                @city_blocks << input.split('').map(&:to_i)
            end
            @destination = {x: @city_blocks[0].length - 1, y: @city_blocks.length - 1}

            @visited_vertices = {}
            @priority_queue = PQueue.new do |x,y|
                x[:priority] < y[:priority]
            end

            first_vertex = {x: 0, y: 0, depth: 0, direction: EAST, parent: nil}
            @priority_queue.push({vertex: first_vertex, priority: 0})
            @final_vertex = {}

            find_minimum_heat_loss_path
        end

        def location_out_of_bounds?(x,y)
            x < 0 || x >= @city_blocks[0].length || y < 0 || y >= @city_blocks.length
        end

        def find_minimum_heat_loss_path
       
            final_val = nil
            # while the priority queue is not empty and the current vertex is not the destination
            while !@priority_queue.empty?
                # pop the top vertex off the priority queue
                # vertex = {x,y,depth,direction}
                # entry = {vertex: vertex, priority: priority}
                entry = @priority_queue.pop

                if entry[:vertex][:x] == @destination[:x] && entry[:vertex][:y] == @destination[:y]
                    if final_val.nil? || entry[:priority] < final_val[:priority]
                        final_val = entry
                    end
                end

                vertex = entry[:vertex]
                curr_direction = vertex[:direction]
                # if we have already visited this vertex skip it
                next if @visited_vertices[vertex]

                # "Visit" all the neighbors of this vertex (by adding them to the priority queue)
                x_offset = 0
                y_offset = 0
                x_offset = curr_direction == EAST ? 1 : -1 if curr_direction == EAST || curr_direction == WEST
                y_offset = curr_direction == NORTH ? -1 : 1 if curr_direction == NORTH || curr_direction == SOUTH

                if !location_out_of_bounds?(vertex[:x] + x_offset, vertex[:y] + y_offset) && vertex[:depth] < 3
                    new_curr_dir_vertex = {x: vertex[:x] + x_offset, y: vertex[:y] + y_offset, depth: vertex[:depth] + 1, direction: curr_direction}
                    new_curr_dir_priority = entry[:priority] + @city_blocks[new_curr_dir_vertex[:y]][new_curr_dir_vertex[:x]]
                    @priority_queue.push({vertex: new_curr_dir_vertex, priority: new_curr_dir_priority})
                end 
                
                if curr_direction == EAST || curr_direction == WEST
                    if !location_out_of_bounds?(vertex[:x], vertex[:y] - 1)
                        north_vertex = {x: vertex[:x], y: vertex[:y] - 1, depth: 1, direction: NORTH}
                        north_priority = entry[:priority] + @city_blocks[north_vertex[:y]][north_vertex[:x]]
                        @priority_queue.push({vertex: north_vertex, priority: north_priority})
                    end
                    if !location_out_of_bounds?(vertex[:x], vertex[:y] + 1)
                        south_vertex = {x: vertex[:x], y: vertex[:y] + 1, depth: 1, direction: SOUTH}
                        south_priority = entry[:priority] + @city_blocks[south_vertex[:y]][south_vertex[:x]]
                        @priority_queue.push({vertex: south_vertex, priority: south_priority})
                    end
                elsif curr_direction == NORTH || curr_direction == SOUTH
                    if !location_out_of_bounds?(vertex[:x] - 1, vertex[:y])
                        west_vertex = {x: vertex[:x] - 1, y: vertex[:y], depth: 1, direction: WEST}
                        west_priority = entry[:priority] + @city_blocks[west_vertex[:y]][west_vertex[:x]]
                        @priority_queue.push({vertex: west_vertex, priority: west_priority})
                    end
                    if !location_out_of_bounds?(vertex[:x] + 1, vertex[:y])
                        east_vertex = {x: vertex[:x] + 1, y: vertex[:y], depth: 1, direction: EAST}
                        east_priority = entry[:priority] + @city_blocks[east_vertex[:y]][east_vertex[:x]]
                        @priority_queue.push({vertex: east_vertex, priority: east_priority})
                    end
                end

                # add this vertex to the visited vertices
                @visited_vertices[vertex] = true
            end

            @final_vertex = final_val
        end
    end
end

puts ChallengeSeventeen.solutions('input.txt')