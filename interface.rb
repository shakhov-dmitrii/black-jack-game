# frozen_string_literal: true

require './game.rb'

class Interface
  attr_reader :game, :flag

  def run
    print 'Enter your name: '
    user_name = gets.chomp
    @game = Game.new(user_name)

    loop do
      @flag = false
      @game.new_round
      user_step
      dealer_step if @flag == false
      puts @game.close_round
      puts round_stat
      puts 'Input 1 to continue, 2 to exit'
      user_input = gets.chomp.to_i
      next if user_input == 1
      break if user_input == 2
    end
  end

  def user_step
    puts "#{@game.user.name} bank: #{@game.user.bank}"
    puts "#{@game.user.name} cadrs: #{@game.user.cards}"
    puts "Your points: #{@game.user.score}"
    return unless @game.user.cards.size < 3

    puts 'Enter 1 to skip, 2 to get new card, 3 to open cards'
    user_input = gets.chomp.to_i
    return if user_input == 1

    game.one_more_card(game.user) if user_input == 2
    @flag = true if user_input == 3
  end

  def dealer_step
    game.one_more_card(game.dealer) if game.dealer.score < 17
  end

  def round_stat
    puts "Your cadrs: #{@game.user.cards}"
    puts "Your points: #{@game.user.score}"
    puts "#{game.dealer.name} cadrs: #{@game.dealer.cards}"
    puts "#{game.dealer.name} points: #{@game.dealer.score}"
  end
end
