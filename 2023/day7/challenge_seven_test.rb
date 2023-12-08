require 'minitest/autorun'
require_relative 'challenge_seven'

class ChallengeSeven_Objects < Minitest::Test
    def test_poker_card_comparison_A_greater_than_5
        card1 = PokerCard.new('A')
        card2 = PokerCard.new('5')
        assert_equal card1 > card2, true
    end

    def test_poker_card_comparison_3_less_than_T
        card1 = PokerCard.new('3')
        card2 = PokerCard.new('T')
        assert_equal card1 < card2, true
    end

    def test_poker_hand_comparison_high_card_vs_one_pair
        hand1 = PokerHand.new("2345A", 0)
        hand2 = PokerHand.new("22345", 0)
        assert_equal hand1 < hand2, true
    end

    def test_poker_hand_comparison_one_pair_vs_two_pairs
        hand1 = PokerHand.new("22345", 0)
        hand2 = PokerHand.new("22335", 0)
        assert_equal hand1 < hand2, true
    end
end
