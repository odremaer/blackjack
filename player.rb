require_relative 'deck'
require_relative 'bank'

class Player
  attr_accessor :cards, :bank

  def initialize(name)
    @cards = []
    @name = name
    @bank = 100
  end

  def take_cards(deck, card)
    2.times do
      cur_card = deck.give_card(card)
      @cards << cur_card
    end
  end

  def take_one_more_card(deck, card)
    if @cards.length == 3
      nil
    else
      cur_card = deck.give_card(card)
      @cards << cur_card
    end
  end

  def current_points
    points = 0
    @cards.each do |card|
      card.each_key do |key|
        points += if key =~ /^[0-910]$/
                    key.to_i
                  elsif key =~ /[JDK]/
                    10
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

  def drop_cards
    @cards = []
  end

  def show_cards
    cards = []
    @cards.each do |card|
      card.each { |card, suit| cards << card + suit }
    end
    cards
  end

  def make_a_bet(bank)
    bank.current_bank += 10
    @bank -= 10
  end
end
