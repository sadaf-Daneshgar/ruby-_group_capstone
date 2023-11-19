require 'date'
class Item
  attr_reader :id, :publish_date

  def initialize(publish_date, archived: true)
    @id = Random.rand(1..1000)
    @publish_date = Date.parse(publish_date)
    @archived = archived
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def source=(source)
    @source = source
    source.add_item(self) unless source.items.include?(self)
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def can_be_archived?
    ten_years_ago = Date.today - 10 * 365
    publish_date < ten_years_ago
  end
end
