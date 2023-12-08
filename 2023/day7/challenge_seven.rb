require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeSeven
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            poker_hands = create_poker_hands(input_list, false)
            poker_hands_with_jokers = create_poker_hands(input_list, true)
            poker_hands.sort!
            poker_hands_with_jokers.sort!

            part_1_sum = 0
            # loop over the poker hands with an index
            poker_hands.each_with_index do |poker_hand, index|
                # multiply the bid by the index + 1
                index_by_bid = poker_hand.bid * (index + 1)
                # add the bid to the sum
                part_1_sum += index_by_bid
            end

            part_2_sum = 0
            # loop over the poker hands with an index
            poker_hands_with_jokers.each_with_index do |poker_hand, index|
                # multiply the bid by the index + 1
                index_by_bid = poker_hand.bid * (index + 1)
                # add the bid to the sum
                part_2_sum += index_by_bid
            end

            [part_1_sum, part_2_sum]
        end

        def create_poker_hands(input_list, with_jokers)
            poker_hands = [] 
            input_list.map do |input|
                hand, bid = input.split(' ')
                poker_hands << PokerHand.new(hand, bid.to_i, with_jokers)
            end
            poker_hands
        end
    end
end

class PokerCard
    include Comparable
    attr_reader :card, :j_isa_joker

    def initialize(card, j_isa_joker = false)
        @card = card
        @j_isa_joker = j_isa_joker
        jval = j_isa_joker ? 1 : 11
        @card_map = {
        '2' => 2,
        '3' => 3,
        '4' => 4,
        '5' => 5,
        '6' => 6,
        '7' => 7,
        '8' => 8,
        '9' => 9,
        'T' => 10,
        'J' => jval,
        'Q' => 12,
        'K' => 13,
        'A' => 14
        }
    end

    def <=>(other)
        @card_map[self.card] <=> @card_map[other.card]
    end

    def inspect
        @card
    end
end

class PokerHand
    include Comparable
    attr_accessor :hand, :bid, :hand_type

    CARD_VALUES = {
        :high_card => 1,
        :one_pair => 2,
        :two_pairs => 3,
        :three_of_a_kind => 4,
        :full_house => 5,
        :four_of_a_kind => 6,
        :five_of_a_kind => 7
    }

    def initialize(hand, bid, with_jokers = false)
        card_strings = hand.split('')
        @hand = card_strings.map { |card_string| PokerCard.new(card_string, with_jokers) }
        @bid = bid
        if with_jokers
            card_strings = replace_jokers(card_strings)
        end
        @hand_type = determine_hand_type(card_strings)
    end

    def determine_hand_type(hand)
        counting_hash = {}
        hand.each do |card|
            if counting_hash[card]
                counting_hash[card] += 1
            else
                counting_hash[card] = 1
            end
        end
        determine_hand_type_from_counting_hash(counting_hash)
    end

    def determine_hand_type_from_counting_hash(counting_hash)
        # loop through the keys
        pairs = 0
        three_of_a_kind = false
        counting_hash.keys.each do |key|
            if counting_hash[key] == 5
                return :five_of_a_kind
            elsif counting_hash[key] == 4
                return :four_of_a_kind
            elsif counting_hash[key] == 3
                three_of_a_kind = true
            elsif counting_hash[key] == 2
                pairs += 1
            end
        end

        if three_of_a_kind && pairs == 1
            return :full_house
        elsif three_of_a_kind
            return :three_of_a_kind
        elsif pairs == 2
            return :two_pairs
        elsif pairs == 1
            return :one_pair
        else
            return :high_card
        end
    end

    def inspect
        @hand
    end

    def <=>(other)
        if self.hand_type == other.hand_type
            # compare by the cards in order
            self.hand <=> other.hand
        else
            CARD_VALUES[self.hand_type] <=> CARD_VALUES[other.hand_type]
        end
    end

    private 

    def replace_jokers(hand)
        counting_hash = {}
        hand.each do |card|
            if card != 'J'
                if counting_hash[card]
                    counting_hash[card] += 1
                else
                    counting_hash[card] = 1
                end
            end
        end
        max_frequency = counting_hash.values.max
        new_hand = []
        hand.map do |card|
            if card == 'J'
                new_hand << counting_hash.key(max_frequency)
            else 
                new_hand << card
            end
        end
        new_hand
    end
end