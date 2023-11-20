require 'date'

class Item
  attr_accessor :genres, :authors, :labels, :source, :publish_date, :archived
  attr_reader :id

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..100)
    @genres = []
    @authors = []
    @labels = []
    @source = []
    @publish_date = publish_date
    @archived = archived
  end

  def add_label(label)
    @labels << label
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def can_be_archived?
    Date.today.year - @publish_date.year > 10
  end
end
