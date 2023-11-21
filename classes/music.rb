require_relative 'item'
class MusicAlbum < Item
  attr_accessor :on_spotify, :genre

  def initialize(genre, on_spotify, publish_date, archived: false)
    super(publish_date, archived: archived)
    @genre = genre
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end
end
