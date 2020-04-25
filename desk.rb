# frozen_string_literal: true

class Desk
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = ['+', '<3', '^', '<>'].freeze

  attr_reader :cards

  def initialize
    @cards = {}
    VALUES.each do |value|
      SUITS.each do |suit|
        score = value if [2, 3, 4, 5, 6, 7, 8, 9, 10].include?(value)
        score = 10 if %w[J Q K].include?(value)
        score = 11 if value == 'A'
        @cards["#{value}#{suit}"] = score
      end
    end
  end

  def shuffled_desk
    @cards.keys.shuffle!
  end

  def card_value(value)
    @cards[value]
  end
end
