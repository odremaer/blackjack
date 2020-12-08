class Hash
  def sample(n)
    Hash[to_a.sample(n)]
  end
end

class Deck
  attr_accessor :playable_deck

  Deck = {
    '2♠' => 2,
    '2♥' => 2,
    '2♣' => 2,
    '2♦' => 2,
    '3♠' => 3,
    '3♥' => 3,
    '3♣' => 3,
    '3♦' => 3,
    '4♠' => 4,
    '4♥' => 4,
    '4♣' => 4,
    '4♦' => 4,
    '5♠' => 5,
    '5♥' => 5,
    '5♣' => 5,
    '5♦' => 5,
    '6♠' => 6,
    '6♥' => 6,
    '6♣' => 6,
    '6♦' => 6,
    '7♠' => 7,
    '7♥' => 7,
    '7♣' => 7,
    '7♦' => 7,
    '8♠' => 8,
    '8♥' => 8,
    '8♣' => 8,
    '8♦' => 8,
    '9♠' => 9,
    '9♥' => 9,
    '9♣' => 9,
    '9♦' => 9,
    '10♠' => 10,
    '10♥' => 10,
    '10♣' => 10,
    '10♦' => 10,
    'J♠' => 10,
    'J♥' => 10,
    'J♣' => 10,
    'J♦' => 10,
    'D♠' => 10,
    'D♥' => 10,
    'D♣' => 10,
    'D♦' => 10,
    'K♠' => 10,
    'K♥' => 10,
    'K♣' => 10,
    'K♦' => 10,
    'A♠' => [1, 11],
    'A♥' => [1, 11],
    'A♣' => [1, 11],
    'A♦' => [1, 11]
  }.freeze
  def initialize
    @playable_deck = Deck.dup
  end

  def give_card
    update_deck if @playable_deck.empty?
    card = @playable_deck.sample(1)
    @playable_deck.delete(card.keys[0])
    card
  end

  protected

  def update_deck
    @playable_deck = Deck.dup
  end
end
