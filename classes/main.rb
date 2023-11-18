def main
  puts 'Welcome to the Catalog of my things App!'
  puts '----------------------------------------'
  loop do
    puts 'Please select an option by entering a number:'
    puts '1. List all books'
    puts '2. List all music albums'
    puts '3. List of games'
    puts '4. List all labels'
    puts '5. List all genres'
    puts '6. List all authors'
    puts '7. Add a book'
    puts '8. Add a music album'
    puts '9. Add a game'
    puts '10. Exit'
    options = gets.chomp.to_i
    case options
    when 1
      puts 'List of all books'
    when 2
      puts 'List of all music albums'
    when 3
      puts 'List of all games'
    when 4
      puts 'List of all labels'
    when 5
      puts 'List of all genres'
    when 6
      puts 'List of all authors'
    when 7
      puts 'Add a book'
    when 8
      puts 'Add a music album'
    when 9
      puts 'Add a game'
    when 10
      puts 'Goodbye!'
      break
    else
      puts 'Invalid option. Please try again.'
    end
  end
end

main
