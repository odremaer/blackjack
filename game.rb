require_relative 'dealer'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
require_relative 'interface'

class Game
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
    @deck = Deck.new
    @interface = Interface.new
  end

  def game_start
    @player.take_cards(@deck)
    @dealer.take_cards(@deck)
    @player.make_a_bet(@bank)
    @dealer.make_a_bet(@bank)
    player_turn
  end

  def player_turn
    game_end if (@player.hand.cards.length == 3) && (@dealer.hand.cards.length == 3)
    choice = @interface.main_message(@player, @dealer, @bank)
    case choice
    when '0'
      dealer_turn
    when '1'
      if @player.hand.cards.length == 3
        @interface.more_than_3_cards
      else
        @player.take_one_more_card(@deck)
      end
      player_turn
    when '2'
      game_end
    end
  end

  def dealer_turn
    @dealer.take_one_more_card(@deck) if @dealer.hand.current_points <= 17
    player_turn
  end

  def game_end
    show_results
    check_if_someone_has_lost
    choice = @interface.wanna_play_again
    case choice
    when '0'
      @player.hand.clear_hand
      @dealer.hand.clear_hand
      game_start
    when '1'
      @interface.exit
    end
  end

  def check_if_someone_has_lost
    if @player.bank.zero?
      @interface.player_out_of_money
      abort
    end

    if @dealer.bank.zero?
      @interface.dealer_out_of_money
      abort
    end
  end

  def show_results
    @interface.point_from_both_sides(@player, @dealer)
    if (@player.hand.current_points == @dealer.hand.current_points) && (@player.hand.current_points <= 21) && (@dealer.hand.current_points <= 21)
      @interface.draw
      @bank.draw(@player, @dealer)
    elsif (@player.hand.current_points >= @dealer.hand.current_points) && (@player.hand.current_points <= 21)
      @interface.player_won
      @bank.player_wins(@player)
    else
      @interface.player_lost
      @bank.dealer_wins(@dealer)
    end
  end
end

print "Введите ваше имя: \n"
name = gets.chomp
Game.new(name).game_start
