require 'date'

class Item
  attr_accessor :genres, :authors, :labels, :source, :publish_date, :archived
  attr_reader :id

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..1000)
    @publish_date = Date.parse(publish_date)
    @archived = archived
  end

  def label=(label)
    @labels << label unless @labels.include?(label)
  end

  def author=(author)
    @authors << author unless @authors.include?(author)
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def can_be_archived?
    Date.today.year - @publish_date.year > 10
  end
end
