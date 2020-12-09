require_relative 'card'

class Deck
  attr_accessor :playable_deck

  def initialize
    @playable_deck = []
  end

  def give_card(card)
    update_deck(card) if @playable_deck.empty?
    cur_card = @playable_deck.sample
    @playable_deck.delete(cur_card)
    cur_card
  end

  def update_deck(card)
    card.card.each do |cur_card|
      card.suit.each do |cur_suit|
        @playable_deck << { cur_card => cur_suit }
      end
    end
  end
end
