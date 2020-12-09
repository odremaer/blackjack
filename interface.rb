class Interface
  def main_message(player, dealer, bank)
    print "Ваши карты - #{player.hand.show_cards}, сумма очков - #{player.hand.current_points}\n"\
          "Карт у диллера - #{'*' * dealer.hand.cards.length}\n"\
          "В банке находится - #{bank.current_bank}\n"\
          "Ваши деньги - #{player.bank}, деньги диллера - #{dealer.bank}\n"\
          "Что вы хотите сделать?\n"\
          "(0) - пропустить ход\t (1) - добавить карту\n"\
          "(2) - открыть карты\n"
    choice = gets.chomp
  end

  def wanna_play_again
    print "Хотите сыграть еще раз?\n"\
          "(0) - да, (1) - нет\n"
    choice = gets.chomp
  end

  def point_from_both_sides(player, dealer)
    print "Ваши карты - #{player.hand.show_cards}, ваши очки - #{player.hand.current_points}\n"\
          "Карты диллера - #{dealer.hand.show_cards}, очки диллера - #{dealer.hand.current_points}\n"
  end

  def more_than_3_cards
    print "У вас 3 карты, больше нельзя\n"
  end

  def player_out_of_money
    print "У вас закончились деньги, вы проиграли\n"
  end

  def dealer_out_of_money
    print "У диллера закончились деньги, вы выиграли!\n"
  end

  def draw
    print "Ничья!\n"
  end

  def player_won
    print "Вы выиграли!\n"
  end

  def player_lost
    print "Вы проиграли\n"
  end

  def exit
    print "Выход\n"
  end
end
