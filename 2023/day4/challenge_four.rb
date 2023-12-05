require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeFour
    class << self
        def solutions(input_file_path)
            list_of_scratch_card_strings = InputFileReader.read_file_to_list(input_file_path)
            scratch_cards = list_of_scratch_card_strings.map { |scratch_card_string| ScratchCard.new(scratch_card_string) }
            part_1_answer = scratch_cards.map { |scratch_card| scratch_card.players_winning_points }.sum
            
            compute_card_copies_won(scratch_cards)
            part_2_answer = scratch_cards.map { |scratch_card| scratch_card.card_copies }.sum
            [part_1_answer, part_2_answer]
        end

        def compute_card_copies_won(scratch_cards)
            scratch_cards.each_with_index do |scratch_card, index|
                card_copies = scratch_card.card_copies
                card_copies_won = scratch_card.players_winning_numbers.size
                (index + 1).upto(index + card_copies_won) do |i|
                    scratch_cards[i].card_copies += card_copies
                end
            end
        end
    end
end

class ScratchCard
    attr_accessor :winning_numbers, :players_numbers, :players_winning_numbers, :players_winning_points, :card_copies

    def initialize(scratch_card_string)
        @winning_numbers, @players_numbers = parse_scratch_card_string(scratch_card_string)
        @players_winning_numbers = compute_players_winning_numbers
        @players_winning_points = compute_players_winning_points
        @card_copies = 1
    end

    def compute_players_winning_points
        winning_points = 0
        @players_winning_numbers.each do |number|
            if winning_points == 0
                winning_points = 1
            else
                winning_points *= 2
            end
        end
        winning_points
    end

    def compute_players_winning_numbers
        @players_numbers.select { |number| @winning_numbers.include?(number) }
    end

    def parse_scratch_card_string(scratch_card_string)
        winning_numbers = Set.new
        players_numbers = []
        numbers_section = scratch_card_string.split(':')[1].strip
        numbers_section.split('|').each_with_index do |section, index|
            section.strip.split.each do |number|
                if index == 0
                    winning_numbers << number.to_i
                else
                    players_numbers << number.to_i
                end
            end
        end

        [winning_numbers, players_numbers]
    end
end
