require_relative 'player'
require_relative 'dealer'

class Bank
  attr_accessor :current_bank

  def initialize
    @current_bank = 0
  end

  def player_wins(player)
    player.bank += @current_bank
    @current_bank = 0
  end

  def dealer_wins(dealer)
    dealer.bank += @current_bank
    @current_bank = 0
  end

  def draw(player, dealer)
    player.bank += @current_bank / 2
    dealer.bank += @current_bank / 2
    @current_bank = 0
  end
end
