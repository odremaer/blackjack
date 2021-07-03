require_relative 'deck'
require_relative 'bank'
require_relative 'hand'

class Dealer
  attr_accessor :bank
  attr_reader :hand

  def initialize
    @bank = 100
    @hand = Hand.new
  end

  def take_cards(deck)
    2.times do
      cur_card = deck.give_card
      @hand.cards << cur_card
    end
  end

  def take_one_more_card(deck)
    if (@hand.cards.length == 3) || (@hand.current_points >= 17)
      nil
    else
      cur_card = deck.give_card
      @hand.cards << cur_card
    end
  end

  def make_a_bet(bank)
    bank.current_bank += 10
    @bank -= 10
  end
end
