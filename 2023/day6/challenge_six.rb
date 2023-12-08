require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeSix
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            times = parse_line_to_numbers(input_list[0])
            distances = parse_line_to_numbers(input_list[1])

            races = []
            times.each_with_index do |time, index|
                distance = distances[index]
                race = Race.new(distance, time)
                races << race
            end

            ways_to_win = []
            races.map do |race|
                ways_to_win << WinsCalculator.calculate_how_many_ways_to_win(race)
            end
            part_1 = ways_to_win.inject(:*)

            long_time = parse_line_to_numbers_remove_spaces(input_list[0])
            long_distance = parse_line_to_numbers_remove_spaces(input_list[1])
            long_race = Race.new(long_distance, long_time)
            part_2 = WinsCalculator.calculate_how_many_ways_to_win(long_race)
            [part_1, part_2]
        end

        def parse_line_to_numbers(line)
            line.split(':')[1].strip.split(' ').map(&:to_i)
        end

        def parse_line_to_numbers_remove_spaces(line)
            line.split(':')[1].strip.gsub(' ', '').to_i
        end
    end
end

class WinsCalculator
    class << self
        def calculate_how_many_ways_to_win(race)
            start_hold_button_time = 1
            end_hold_button_time = race.time - 1
            ways_to_win = 0
            (start_hold_button_time..end_hold_button_time).each do |hold_button_time|
                milimeters_per_second = hold_button_time
                travel_time = race.time - hold_button_time
                distance = milimeters_per_second * travel_time
                if distance > race.distance
                    ways_to_win += 1
                end
            end
            ways_to_win
        end
    end
end

class Race
    attr_reader :time, :distance

    def initialize(distance, time)
        @distance = distance
        @time = time
    end

    def inspect
        "Distance: #{@distance} Fastest Time: #{@best_time}"
    end
end




