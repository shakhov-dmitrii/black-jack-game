# frozen_string_literal: true

class User
  attr_accessor :cards, :score
  attr_reader :name, :bank

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @score = 0
  end

  def do_bet(value)
    @bank -= value
  end

  def take_a_win(value)
    @bank += value
  end
end
