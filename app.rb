require_relative 'classes/game'
require_relative 'classes/author'
require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/music'
require_relative 'classes/genre'
require 'json'

class App
  attr_accessor :games, :authors, :labels, :books, :music_albums, :genres

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
    print 'Is the game multiplayer [Y/N] : '
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
    puts 'The Game is added successfully'
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
    print 'Enter the genre of the music album: '
    genre_name = gets.chomp
    genre = find_or_create_genre(genre_name)
    on_spotify = ask_spotify
    print 'Add the publish date of your music album [yyyy/mm/dd] : '
    publish_date = gets.chomp
    music_album = MusicAlbum.new(genre, on_spotify, publish_date)
    @music_albums << music_album
    puts 'The Music Album is added successfully ✅🎵'
    puts '--------------------------------------'
    puts ' '
  end  

  def list_all_music_albums
    puts 'List of all music albums:'
    @music_albums.each do |music_album|
      puts "ID: #{music_album.id}, Genre: #{music_album.genre.name}, On Spotify: #{music_album.can_be_archived?}, Published Date: #{music_album.publish_date}"
      puts '-------------------------'
    end
  end
  
  def list_all_genres
    puts 'List all genres:'
    @genres.each do |genre|
      puts "#{genre.name}"
      puts '............'
    end
  end  

  def save_data
    save_games
    save_authors
    save_books
    save_labels
    save_music_albums
    save_genres
  end

  def load_data
    load_games
    load_authors
    load_books
    load_labels
    load_music_albums
    load_genres
  end

  private

  def load_books
    if File.exist?('data/book.json')
      data = JSON.parse(File.read('data/book.json'))
      @books = data.map { |book| Book.new(book['publish_date'], book['publisher'], book['cover_state']) }
    else
      []
    end
  end

  def save_books
    File.open('data/book.json', 'w') do |file|
      data = @books.map do |book|
        {
          'id' => book.id,
          'publish_date' => book.publish_date,
          'publisher' => book.publisher,
          'cover_state' => book.cover_state
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def load_labels
    if File.exist?('data/label.json')
      data = JSON.parse(File.read('data/label.json'))
      @labels = data.map { |label| Label.new(label['title'], label['color']) }
    else
      []
    end
  end

  def save_labels
    File.open('data/label.json', 'w') do |file|
      data = @labels.map do |label|
        {
          'title' => label.title,
          'color' => label.color
        }
      end
      file.write(JSON.generate(data))
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

  def load_games
    if File.exist?('data/game.json')
      data = JSON.parse(File.read('data/game.json'))
      @games = data.map { |game| Game.new(game['publish_date'], game['multiplayer'], game['last_played_at']) }
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

  def load_authors
    if File.exist?('data/author.json')
      data = JSON.parse(File.read('data/author.json'))
      @authors = data.map { |author| Author.new(author['first_name'], author['last_name']) }
    else
      []
    end
  end

  def load_music_albums
    if File.exist?('data/music.json')
      data = JSON.parse(File.read('data/music.json'))
      @music_albums = data.map do |music_data|
        genre_name = music_data['genre'] && music_data['genre']['name']
        genre = find_or_create_genre(genre_name)
        MusicAlbum.new(genre, music_data['on_spotify'], music_data['published_date'])
      end
    else
      []
    end
  end

  def save_music_albums
    File.open('data/music.json', 'w') do |file|
      data = @music_albums.map do |music_album|
        {
          'id' => music_album.id,
          'on_spotify' => music_album.on_spotify,
          'genre' => music_album.genre ? { 'id' => music_album.genre.id, 'name' => music_album.genre.name } : nil,
          'published_date' => music_album.publish_date
        }
      end
      file.write(JSON.generate(data))
    end
  end
  

  def load_genres
    if File.exist?('data/genre.json')
      data = JSON.parse(File.read('data/genre.json'))
      @genres = data.map { |genre_data| Genre.new(genre_data['name']) }
  
      @music_albums.each do |music_album|
        genre_name = music_album.genre.name
        loaded_genre = @genres.find { |genre| genre.name == genre_name }
        music_album.genre = loaded_genre if loaded_genre
      end
    else
      []
    end
  end

  def save_genres
    File.open('data/genre.json', 'w') do |file|
      data = @genres.map do |genre|
        {
          'id' => genre.id,
          'name' => genre.name
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def find_or_create_genre(name)
    existing_genre = @genres.find { |genre| genre.name == name }
    return existing_genre if existing_genre

    genre = Genre.new(name)
    @genres << genre
    genre
  end

  def ask_spotify
    print 'Is the music album on Spotify? [Y/N]: '
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
end


