require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            map = input_list.map { |row| row.split('') }
            # universe = Universe.new(map)
            # distances_between_galaxies = universe.find_distances_between_galaxies
            # part_1 = distances_between_galaxies.sum
            # part_1

            second_universe = Universe.new(map, 1)
            distances_between_galaxies_2 = second_universe.find_distances_between_galaxies
            part_2 = distances_between_galaxies_2.sum
            part_2
        end
    end
end

class Universe
    attr_reader :map, :galaxies, :rows_without_galaxies, :cols_without_galaxies

    def initialize(map, expand_by = 1)
        @map = map.clone
        @galaxies = []
        setup_rows_and_cols_without_galaxies
        find_galaxies
        expand_universe(expand_by)

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


    def find_distances_between_galaxies
        distances = []
        galaxies_copy = @galaxies.clone

        while galaxies_copy.length > 0
            galaxy = galaxies_copy.shift
            galaxies_copy.each do |other_galaxy|
                distance = calculate_distance(galaxy, other_galaxy)
                #print "Galaxy 1: #{galaxy[0]} #{galaxy[1]} Galaxy 2: #{other_galaxy[0]} #{other_galaxy[1]} Distance: #{distance}\n"
                distances << distance
            end
        end
        distances
    end

    def calculate_distance(galaxy, other_galaxy)
        row_distance = (galaxy[0] - other_galaxy[0]).abs
        col_distance = (galaxy[1] - other_galaxy[1]).abs
        row_distance + col_distance
    end

    def expand_universe(expand_by = 1)
        # for each row without a galaxy add another empty row below it
        length = @map[0].length
        new_empty_row = Array.new(length, '.')
        offset_row = 0
        @rows_without_galaxies.each do |row_index|
            expand_by.times do
                @map.insert(row_index + offset_row, new_empty_row.clone)
                offset_row += 1
            end
        end

        # for each col without a galaxy add another empty col to the right of it
        @map.each_with_index do |row|
            offset_col = 0
            @cols_without_galaxies.sort.each do |col_index|
                expand_by.times do
                    row.insert(col_index + offset_col, '.')
                    offset_col += 1
                end
            end
        end
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

puts ChallengeTen.solutions('input.txt')


    