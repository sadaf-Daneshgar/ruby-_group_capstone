require_relative '../classes/label'
require_relative '../classes/item'
require 'rspec'

describe Label do
  before :each do
    @label = Label.new('Title', 'Color')
    @item = Item.new('2000-01-01')
  end

  it 'initializes with correct attributes' do
    expect(@label.title).to eq('Title')
    expect(@label.color).to eq('Color')
    expect(@label.items).to eq([])
  end

  it 'adds an item to items' do
    @label.add_item(@item)
    expect(@label.items).to include(@item)
  end

  it 'does not add an item to items if it already exists' do
    @label.add_item(@item)
    @label.add_item(@item)
    expect(@label.items.count(@item)).to eq(1)
  end

  it 'adds self to item labels' do
    @label.add_item(@item)
    expect(@item.labels).to include(@label)
  end
end