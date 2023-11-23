require_relative '../classes/author'
require_relative '../classes/item'

describe Author do
  let(:author) { Author.new('John', 'Doe') }
  let(:item) { Item.new(Date.today, archived: false) }

  describe '#new' do
    it 'returns an instance of the Author class' do
      expect(author).to be_an_instance_of(Author)
    end
  end

  describe '#id' do
    it 'returns a non-nil id' do
      expect(author.id).to_not be_nil
    end
  end

  describe '#first_name' do
    it 'returns the first name of the author' do
      expect(author.first_name).to eq('John')
    end
  end

  describe '#last_name' do
    it 'returns the last name of the author' do
      expect(author.last_name).to eq('Doe')
    end
  end

  describe '#items' do
    it 'returns an empty array initially' do
      expect(author.items).to be_empty
    end
  end
end
