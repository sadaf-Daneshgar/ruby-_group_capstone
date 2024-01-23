require 'rspec'
require_relative '../classes/label'

describe Label do
  before :each do
    @label = Label.new('Gift', 'red')
  end

  it 'has a title' do
    expect(@label.title).to eq('Gift')
  end

  it 'has a color' do
    expect(@label.color).to eq('red')
  end

  it 'has an id' do
    expect(@label.id).to be_a(Integer)
  end

  it 'starts with no items' do
    expect(@label.items).to eq([])
  end

  describe '#add_item' do
    before :each do
      @item = double('Item')
      allow(@item).to receive(:label=)
      @label.add_item(@item)
    end

    it 'adds the item to the label' do
      expect(@label.items).to include(@item)
    end

    it 'sets the label of the item to the current label' do
      expect(@item).to have_received(:label=).with(@label)
    end
  end
end
