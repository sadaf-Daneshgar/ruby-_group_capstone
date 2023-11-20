require_relative 'item'

class Book < Item
  attr_accessor :publisher, :publish_date, :cover_state

  def initialize(publish_date, publisher, cover_state, archived: true)
    super(publish_date, archived: archived)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
