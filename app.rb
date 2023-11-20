require_relative 'classes/game'
require_relative 'classes/author'

class App
  attr_accessor :game, :author

  def initialize
    @games = []
    @authors = []
  end

  def ask_multiplayer
    print 'Isthe game multiplayer [Y/N] : '
    loop do
      input = gets.chomp.downcase
      case input
      when 'y'
        return true
      when 'n'
        return false
      else
        print 'Please enter a valid input "Y" or "N" :'
      end
    end
  end

  def add_game
    puts 'Please add a game'
    print 'Add the publish date of your game [yyyy/mm/dd] : '
    publish_date = gets.chomp
    multiplayer = ask_multiplayer
    print 'Last the game was played [yyyy/mm/dd] : '
    last_time = gets.chomp
    game = Game.new(publish_date, multiplayer, last_time)
    @games << game
    puts 'The Game is added sucessfully/n'
  end

  def list_games
    puts 'No game added' if @games.empty?
    @games.each_with_index do |game, index|
      print "Game #{index + 1} - "
      print "Publish Date: #{game.publish_date}, "
      print "Multiplayer: #{game.multiplayer}, "
      print "Last Played at: #{game.last_played_at}\n"
    end
  end

  def add_author
    puts 'Please add an author'
    print 'Enter the first name of the author : '
    first_name = gets.chomp
    print 'Enter the last name of the author : '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    @authors << author
    puts ' Author is added successfully '
  end

  def list_authors
    puts 'No author added' if @authors.empty?
    @authors.each_with_index do |author, index|
      puts "Author #{index + 1} - Fullname: #{author.first_name} #{author.last_name}"
    end
  end
end
