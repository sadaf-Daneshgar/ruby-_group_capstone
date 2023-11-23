require_relative '../classes/genre'
require_relative '../classes/item'
require_relative '../classes/music'
require 'rspec'

describe Genre do
  let(:genre) { Genre.new('Pop') }

  describe '#new' do
    it 'returns an instance of the Genre class' do
      expect(genre).to be_an_instance_of(Genre)
    end
  end

  describe '#name' do
    it 'returns the name of the genre' do
      expect(genre.name).to eq('Pop')
    end
  end

  describe '#items' do
    it 'returns an empty array initially' do
      expect(genre.items).to be_empty
    end

    it 'adds an item to the genre' do
      item = Item.new('2000-01-01')
      genre.add_item(item)
      expect(genre.items).to include(item)
    end

    it 'adds a music album to the genre' do
      music_album = MusicAlbum.new(genre, true, '2000-01-01')
      genre.add_item(music_album)
      expect(genre.items).to include(music_album)
    end
  end
end
