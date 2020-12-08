require_relative 'dealer'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
class Interface
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
    @deck = Deck.new
  end

  def game_start
    @player.take_cards(@deck)
    @dealer.take_cards(@deck)
    @player.make_a_bet(@bank)
    @dealer.make_a_bet(@bank)
    player_turn
  end

  def player_turn
    game_end if (@player.cards.length == 3) && (@dealer.cards.length == 3)
    print "Ваши карты - #{@player.show_cards}, сумма очков - #{@player.current_points}\n"\
          "Карт у диллера - #{'*' * @dealer.cards.length}\n"\
          "В банке находится - #{@bank.current_bank}\n"\
          "Ваши деньги - #{@player.bank}, деньги диллера - #{@dealer.bank}\n"\
          "Что вы хотите сделать?\n"\
          "(0) - пропустить ход\t (1) - добавить карту\n"\
          "(2) - открыть карты\n"
    choice = gets.chomp
    case choice
    when '0'
      dealer_turn
    when '1'
      if @player.cards.length == 3
        print "У вас 3 карты, больше нельзя\n"
      else
        @player.take_one_more_card(@deck)
      end
      player_turn
    when '2'
      game_end
    end
  end

  def dealer_turn
    @dealer.take_one_more_card(@deck) if @dealer.current_points <= 17
    player_turn
  end

  def game_end
    show_results
    check_if_someone_has_lost

    print "Хотите сыграть еще раз?\n"\
          "(0) - да, (1) - нет\n"
    choice = gets.chomp
    case choice
    when '0'
      @player.drop_cards
      @dealer.drop_cards
      game_start
    when '1'
      print "Выход\n"
    end
  end

  def check_if_someone_has_lost
    if @player.bank.zero?
      print "У вас закончились деньги, вы проиграли\n"
      return nil
    end

    if @dealer.bank.zero?
      print "У диллера закончились деньги, вы выиграли!\n"
      return nil
    end
  end

  def show_results
    print "Ваши карты - #{@player.show_cards}, ваши очки - #{@player.current_points}\n"\
          "Карты диллера - #{@dealer.show_cards}, очки диллера - #{@dealer.current_points}\n"
    if (@player.current_points == @dealer.current_points) && (@player.current_points <= 21) && (@dealer.current_points <= 21)
      print "Ничья!\n"
      @bank.draw(@player, @dealer)
    elsif (@player.current_points >= @dealer.current_points) && (@player.current_points <= 21)
      print "Вы выиграли!\n"
      @bank.player_wins(@player)
    else
      print "Вы проиграли\n"
      @bank.dealer_wins(@dealer)
    end
  end
end

print "Введите ваше имя: \n"
name = gets.chomp
Interface.new(name).game_start
