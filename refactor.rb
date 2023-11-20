class Refactor
  def initialize(app)
    @app = app
  end

  def add_book
    print 'Book publisher: '
    publisher = gets.chomp
    cover_state = ask_cover_state
    print 'Book publish date [yyyy/mm/dd]: '
    publish_date = gets.chomp
    label_name = ask_label_name
    label_color = ask_label_color
    @app.add_book(publisher, cover_state, publish_date)
    @app.add_label(label_name, label_color)
  end

  def ask_label_name
    print "Book's label name: "
    gets.chomp
  end

  def ask_label_color
    print "Book's label color: "
    gets.chomp
  end

  def ask_cover_state
    print 'Cover state of the book [good/bad]: '
    loop do
      input = gets.chomp.downcase
      case input
      when 'good'
        return 'good'
      when 'bad'
        return 'bad'
      else
        print 'Please enter a valid input "good" or "bad": '
      end
    end
  end
end
