require_relative 'item'
require 'date'


class Game < Item
  attr_accessor :publish_date, :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && (Date.today - Date.parse(@last_played_at) > 2)
  end
end

game = Game.new('2023-02-02', 'yes', '2022-11-18')

puts game.can_be_archived?
