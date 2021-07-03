require_relative 'card'

class Deck
  attr_accessor :playable_deck

  def initialize
    @playable_deck = []
  end

  def give_card
    update_deck if @playable_deck.empty?
    cur_card = @playable_deck.sample
    @playable_deck.delete(cur_card)
    cur_card
  end

  def update_deck
    Card::CARDS.each do |cur_card|
      Card::SUITS.each do |cur_suit|
        @playable_deck << Card.new(cur_card, cur_suit)
      end
    end
  end
end
