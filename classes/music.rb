class MusicAlbum < Item
  attr_accessor :on_spotify, :genre

  def initialize(genre, on_spotify, publish_date, archived: false)
    super(publish_date, archived: archived)
    @genre = genre
    @on_spotify = on_spotify
  end
end
