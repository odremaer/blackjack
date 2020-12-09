class Card
  Card = %w[2 3 4 5 6 7 8 9 10 J D K T].freeze
  Suit = ['♠', '♥', '♣', '♦'].freeze

  def card
    Card
  end

  def suit
    Suit
  end
end
