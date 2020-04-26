# frozen_string_literal: true

class Game
  attr_reader :user, :dealer, :desk, :shuffled_desk, :card_index, :round_bank

  REGULAR_BANK = 10

  def initialize
    print 'Enter your name: '
    user_name = gets.chomp
    @user = User.new(user_name)
    @dealer = User.new('Dealer')

    @desk = Desk.new
    @shuffled_desk = desk.shuffled_desk
    @card_index = 0
    @round_bank = 0
  end

  def new_round
    @user.cards = []
    @dealer.cards = []
    @round_bank = 0
    new_card_distribution
    @user.do_bet(REGULAR_BANK)
    @dealer.do_bet(REGULAR_BANK)
    @round_bank += REGULAR_BANK * 2
  end

  def close_round
    winner = find_winner
    if winner
      winner.take_a_win(@round_bank)
      "#{winner.name} is win!"
    else
      @user.take_a_win(@round_bank / 2)
      @dealer.take_a_win(@round_bank / 2)
      'Draw game...'
    end
  end

  def one_more_card(user)
    user.cards << @shuffled_desk[@card_index]
    user.score += @desk.card_value(@shuffled_desk[@card_index])
    @card_index += 1
  end

  private

  def new_card_distribution
    (@card_index..@card_index + 3).each_with_index do
      if @card_index.even? || @card_index.zero?
        @user.cards << @shuffled_desk[@card_index]
        @user.score += @desk.card_value(@shuffled_desk[@card_index])
      elsif @card_index.odd?
        @dealer.cards << @shuffled_desk[@card_index]
        @dealer.score += @desk.card_value(@shuffled_desk[@card_index])
      end
      @card_index += 1
    end
  end

  def find_winner
    if @user.score > @dealer.score && @user.score <= 21 ||
       @dealer.score > 21 && user.score <= 21
      @user
    elsif @dealer.score > @user.score && @dealer.score <= 21 ||
          @dealer.score <= 21 && user.score > 21
      @dealer
    else
      false
    end
  end
end
