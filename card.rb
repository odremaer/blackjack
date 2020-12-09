class Card
  attr_reader :card, :value, :suit

  CARDS = %w[2 3 4 5 6 7 8 9 10 J D K T].freeze
  SUITS = ['♠', '♥', '♣', '♦'].freeze

  def initialize(card=nil, suit=nil)
    @card = card
    @suit = suit
    @value = if card =~ /^[0-910]$/
                card.to_i
              elsif card =~ /[JDK]/
               10
             elsif card =~ /[T]/
               11
              end
  end

  def cards
    CARDS
  end

  def suits
    SUITS
  end
end
