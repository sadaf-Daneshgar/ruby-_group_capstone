require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :genre

  def initialize(publish_date, on_spotify: false, genre: nil, archived: false)
    super(publish_date, archived: archived)
    @on_spotify = on_spotify
    @genre = genre
  end

  def can_be_archived?
    super && @on_spotify
  end
end
