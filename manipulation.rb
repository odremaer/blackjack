require_relative 'dealer'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
require_relative 'card'
require_relative 'interface'

class Manipulation
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
    @deck = Deck.new
    @card = Card.new
    @interface = Interface.new
  end

  def game_start
    @player.take_cards(@deck, @card)
    @dealer.take_cards(@deck, @card)
    @player.make_a_bet(@bank)
    @dealer.make_a_bet(@bank)
    player_turn
  end

  def player_turn
    game_end if (@player.cards.length == 3) && (@dealer.cards.length == 3)
    choice = @interface.main_message(@player, @dealer, @bank)
    case choice
    when '0'
      dealer_turn
    when '1'
      if @player.cards.length == 3
        @interface.more_than_3_cards
      else
        @player.take_one_more_card(@deck, @card)
      end
      player_turn
    when '2'
      game_end
    end
  end

  def dealer_turn
    @dealer.take_one_more_card(@deck, @card) if @dealer.current_points <= 17
    player_turn
  end

  def game_end
    show_results
    check_if_someone_has_lost
    choice = @interface.wanna_play_again
    case choice
    when '0'
      @player.drop_cards
      @dealer.drop_cards
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
    if (@player.current_points == @dealer.current_points) && (@player.current_points <= 21) && (@dealer.current_points <= 21)
      @interface.draw
      @bank.draw(@player, @dealer)
    elsif (@player.current_points >= @dealer.current_points) && (@player.current_points <= 21)
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
Manipulation.new(name).game_start
