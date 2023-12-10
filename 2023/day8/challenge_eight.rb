require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeEight
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            instructions = input_list[0].split('');
            input_list.shift(2)
            network = Network.new(input_list, "AAA")
            num_moves = network.move_to("Z", instructions)
            part_1 = num_moves
            part_1

            start_nodes = network.node_map.select { |key, value| key.end_with?("A") }.keys
            distances_to_end_nodes = []
            start_nodes.each do |start_node|
                # find the distance from a start node to its first Z node
                network.curr_node = start_node
                distances_to_end_nodes << network.move_to("Z", instructions)
            end
            part_2 = distances_to_end_nodes.reduce(1) { |acc, n| acc.lcm(n) } 
            [part_1, part_2]
        end
    end
end

class Node
    attr_reader :left, :right

    def initialize(node_string)
        # convert a string of the form "(AAA, BBB)" to a node
        node_string = node_string.gsub!(/\(|\)/, '')
        parts = node_string.split(',')

        @left = parts[0].strip
        @right = parts[1].strip
    end

    def to_s
        "(#{@left}, #{@right})"
    end
end

class Network
    attr_reader :node_map, :curr_node, :z_positions
    attr_accessor :curr_node

    def initialize(node_map_strings, curr_node)
        @node_map = parse_node_map(node_map_strings)
        @curr_node = curr_node
        @z_positions = {}
    end

    def move_to(target_node, instructions)
        num_instructions = instructions.length
        moves = 0
        index = 0
        ends_with = target_node.length == 1
        while (ends_with ? (@curr_node[2] != target_node || moves ==0) : (@curr_node != target_node || moves == 0))
            curr_instruction = instructions[index]
            if curr_instruction == 'L'
                @curr_node = @node_map[@curr_node].left
            else
                @curr_node = @node_map[@curr_node].right
            end
            moves+=1
            index = moves % num_instructions
        end
        moves
    end

    def parse_node_map(node_map_strings)
        node_map = {}
        node_map_strings.each do |node_map_string|
            parts = node_map_string.split('=')
            node_map[parts[0].strip] = Node.new(parts[1].strip)
        end
        node_map
    end

    def to_s
        output = ""
        @node_map.each do |key, value|
            output+="#{key} => #{value}\n"
        end
        output
    end
end