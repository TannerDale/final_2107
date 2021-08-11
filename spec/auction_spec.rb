require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  context 'initialize' do
    auction = Auction.new

    it 'exists' do
      expect(auction).to be_a(Auction)
    end

    it 'has attributes' do
      expect(auction.items).to eq([])
    end
  end

  context 'behaivors' do
    auction = Auction.new
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')

    it 'can add and have names of items' do
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.items).to eq([item1, item2])
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end
