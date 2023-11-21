require_relative 'classes/game'
require_relative 'classes/author'
require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/music'
require_relative 'classes/genre'
require 'json'

class App
  attr_accessor :game, :author, :books, :labels, :music_albums, :genres

  def initialize
    @games = []
    @authors = []
    @labels = []
    @books = []
    @music_albums = []
    @genres = []
  end

  def add_label(title, color)
    label = Label.new(title, color)
    @labels << label
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels added'
      puts ' '
    else
      puts 'List of all labels:'
      @labels.each_with_index do |label, index|
        puts "#{index + 1}. Label: #{label.title}, Color: #{label.color}"
        puts ' '
      end
    end
  end

  def list_all_books
    if @books.empty?
      puts 'No books added'
      puts ' '
    else
      @books.each_with_index do |book, index|
        print "#{index + 1}-[Book], "
        print "ID: #{book.id}, "
        print "Publisher: #{book.publisher}, "
        print "Publish Date: #{book.publish_date}, "
        print "Cover State: #{book.cover_state}, "
        puts "Archived: #{book.can_be_archived?}"
        puts ' '
      end
    end
  end

  def add_book(publisher, cover_state, publish_date)
    book = Book.new(publish_date, publisher, cover_state)
    @books << book
    puts ' '
    puts 'The book is added successfully ✅📖'
    puts '--------------------------------------'
    puts ' '
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

  def list_authors
    puts 'No author added' if @authors.empty?
    @authors.each_with_index do |author, index|
      puts "Author #{index + 1} - Fullname: #{author.first_name} #{author.last_name}"
    end
  end

  def add_music_album
    puts 'Please add a music album'
    print 'Is the album on Spotify? [Y/N]: '
    on_spotify = gets.chomp.downcase == 'y'
    print 'Enter the genre of the album: '
    genre_name = gets.chomp
    genre = find_or_create_genre(genre_name)
    print 'Add the publish date of your album [yyyy/mm/dd] : '
    publish_date = gets.chomp
    music_album = MusicAlbum.new(publish_date, on_spotify: on_spotify, genre: genre)
    music_albums << music_album
    puts 'The Music Album is added successfully'
  end

  def list_music_albums
    puts 'No music albums added' if music_albums.empty?
    music_albums.each do |music_album|
      puts "ID: #{music_album.id}, Genre: #{music_album.genre.name}, On Spotify: #{music_album.on_spotify}, Published Date: #{music_album.publish_date}"
      puts '-------------------------'
    end
  end

  def list_genres
    puts 'No genres added' if genres.empty?
    genres.each do |genre|
      puts genre.name
      puts '............'
    end
  end

  def save_data
    save_games
    save_authors
    save_genres
    save_music_albums
  end

  def load_data
    load_games
    load_authors
    load_genres
  end

  private

  def load_authors
    if File.exist?('data/author.json')
      data = JSON.parse(File.read('data/author.json'))
      @authors = data.map { |author| Author.new(author['first_name'], author['last_name']) }
    else
      []
    end
  end

  def save_authors
    File.open('data/author.json', 'w') do |file|
      data = @authors.map do |author|
        {
          'first_name' => author.first_name,
          'last_name' => author.last_name
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def find_or_create_genre(name)
    existing_genre = genres.find { |genre| genre.name == name }
    return existing_genre if existing_genre

    new_genre = Genre.new(generate_genre_id, name)
    genres << new_genre
    new_genre
  end

  def generate_genre_id
    existing_ids = genres.map(&:id)
    new_id = nil
    loop do
      new_id = rand(1..1000)
      break unless existing_ids.include?(new_id)
    end
    new_id
  end

  def load_games
    if File.exist?('data/game.json')
      data = JSON.parse(File.read('data/game.json'))
      @games = data.map { |game| Game.new(game['publish_date'], game['multiplayer'], game['last_played_at']) }
    else
      []
    end
  end

  def save_games
    File.open('data/game.json', 'w') do |file|
      data = @games.map do |game|
        {
          'publish_date' => game.publish_date,
          'multiplayer' => game.multiplayer,
          'last_played_at' => game.last_played_at
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def save_music_albums
    File.open('data/album.json', 'w') do |file|
      data = music_albums.map do |_music_album|
        {
          'first_name' => author.first_name,
          'last_name' => author.last_name
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def load_genres
    if File.exist?('data/genre.json')
      data = JSON.parse(File.read('data/genre.json'))
      self.genres = data.map { |genre_data| Genre.new(genre_data['id'], genre_data['name']) }
    else
      self.genres = []
    end
  end

  def save_genres
    File.open('data/genre.json', 'w') do |file|
      data = genres.map do |genre|
        {
          'id' => genre.id,
          'name' => genre.name
        }
      end
      file.write(JSON.generate(data))
    end
  end
end
