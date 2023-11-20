class Genre
  attr_reader :id, :name
  attr_accessor :items

  def initialize(id, name)
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    return if @items.include?(item)

    @items << item
    item.genre = self
  end
end
