require_relative 'deck'
require_relative 'bank'

class Dealer
  attr_accessor :cards, :bank

  def initialize
    @cards = []
    @bank = 100
  end

  def take_cards(deck)
    2.times do
      card = deck.give_card
      @cards << card
    end
  end

  def take_one_more_card(deck)
    if (@cards.length == 3) || (current_points >= 17)
      nil
    else
      card = deck.give_card
      @cards << card
    end
  end

  def current_points
    points = 0
    @cards.each do |card|
      card.each_value do |value|
        points += if value != [1, 11]
                    value
                  else
                    if points <= 10
                      11
                    else
                      1
                    end
                  end
      end
    end
    points
  end

  def make_a_bet(bank)
    bank.current_bank += 10
    @bank -= 10
  end

  def show_cards
    cards = []
    @cards.each do |card|
      card.each_key { |name| cards << name }
    end
    cards
  end

  def drop_cards
    @cards = []
  end
end
