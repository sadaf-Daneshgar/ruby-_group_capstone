require_relative '../classes/music'
require_relative '../classes/genre'
require_relative '../classes/item'
require 'date'
require 'rspec'

describe MusicAlbum do
  let(:genre) { Genre.new('Rock') }

  before :each do
    @music_album = MusicAlbum.new(genre, true, '2000-01-01')
  end

  describe '#new' do
    it 'returns an instance of the MusicAlbum class' do
      expect(@music_album).to be_an_instance_of(MusicAlbum)
    end
  end

  describe '#genre' do
    it 'returns the genre of the music album' do
      expect(@music_album.genre).to eq(genre)
    end
  end

  describe '#on_spotify' do
    it 'returns true if the music album is on Spotify' do
      expect(@music_album.on_spotify).to be_truthy
    end
  end

  describe '#publish_date' do
    it 'returns the publish date of the music album' do
      expect(@music_album.publish_date.to_s).to eq('2000-01-01')
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if it is more than 10 years passed since publishing and on Spotify, otherwise false' do
      expect(@music_album.can_be_archived?).to be_truthy
      music_album2 = MusicAlbum.new(genre, false, '2021-01-01')
      expect(music_album2.can_be_archived?).to be_falsy
    end
  end
end
