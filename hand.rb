class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def clear_hand
    @cards = []
  end

  def current_points
    t_founded = false
    points = 0
    @cards.each do |card|
      if card.card =~ /[0-910]/
        points += card.value
      elsif card.card =~ /[JDK]/
        points += card.value
      elsif card.card =~ /[T]/
        points += card.value
        t_founded = true
      end
    end
    if t_founded and points > 21
      points -= 10
    end
    points
  end

  def show_cards
    cards = []
    @cards.each do |card|
      cards << card.card + card.suit
    end
    cards
  end
end
