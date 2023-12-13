require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeEleven
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            map = input_list.map { |row| row.split('') }
            universe = Universe.new(map)
            distances_between_galaxies_part1 = universe.find_distances_between_galaxies(2)
            part_1 = distances_between_galaxies_part1.sum
            distances_between_galaxies_part2 = universe.find_distances_between_galaxies(1000000)
            part_2 = distances_between_galaxies_part2.sum
            [part_1, part_2]
        end
    end
end

class Universe
    attr_reader :map, :galaxies, :rows_without_galaxies, :cols_without_galaxies

    def initialize(map)
        @map = map.clone
        @galaxies = []
        setup_rows_and_cols_without_galaxies
        find_galaxies
    end

    def setup_rows_and_cols_without_galaxies
        @rows_without_galaxies = Set.new
        @cols_without_galaxies = Set.new
        @map[0].length.times do |index|
            @cols_without_galaxies.add(index)
        end

        @map.length.times do |index|
            @rows_without_galaxies.add(index)
        end
    end


    def find_distances_between_galaxies(expansion = 2)
        distances = []
        galaxies_copy = @galaxies.clone

        while galaxies_copy.length > 0
            galaxy = galaxies_copy.shift
            galaxies_copy.each do |other_galaxy|
                distance = calculate_distance(galaxy, other_galaxy, expansion)
                #print "Galaxy 1: #{galaxy[0]} #{galaxy[1]} Galaxy 2: #{other_galaxy[0]} #{other_galaxy[1]} Distance: #{distance}\n"
                distances << distance
            end
        end
        distances
    end

    def calculate_distance(galaxy, other_galaxy, expansion)
        # if the difference between galaxy rows passes through an empty row add the 
        # expanion multiplier to the distance

        expansion_distance = 0
        @rows_without_galaxies.each do |row|
            if row > galaxy[0] && row < other_galaxy[0] || row < galaxy[0] && row > other_galaxy[0]
                expansion_distance += expansion - 1
            end
        end

        @cols_without_galaxies.each do |col|
            if col > galaxy[1] && col < other_galaxy[1] || col < galaxy[1] && col > other_galaxy[1]
                expansion_distance += expansion - 1
            end
        end

        row_distance = (galaxy[0] - other_galaxy[0]).abs
        col_distance = (galaxy[1] - other_galaxy[1]).abs
        row_distance + col_distance + expansion_distance
    end

    def find_galaxies
        @galaxies = []
        @map.each_with_index do |row, row_index|
            row.each_with_index do |col, col_index|
                if col == '#'
                    row_has_galaxy = true
                    col_with_galaxy = col_index
                    @galaxies << [row_index, col_index]
                    @rows_without_galaxies.delete(row_index)
                    @cols_without_galaxies.delete(col_index)
                end
            end
        end
    end

    def to_s
        @map.each do |row|
            puts row.join('')
        end
    end
end


    