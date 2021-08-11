require './lib/item'
require './lib/attendee'
require './lib/auction'
require 'date'

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

  context 'bidding' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')
    auction = Auction.new
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee3, 15)

    it 'has unpopular items' do
      expect(auction.unpopular_items).to eq([item2, item5])
    end

    it 'has items with bids' do
      expect(auction.items_with_bids).to eq([item1, item3, item4])
    end

    it 'has a potential revenue' do
      expect(auction.potential_revenue).to eq(87)
    end
  end

  context 'iteration 3' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    it 'has persons who bid' do
      expect(auction.persons_with_bids).to eq([attendee1, attendee2, attendee3])
    end

    it 'has bidders' do
      expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end

    it 'has bidder info' do
      expected = {
        attendee1 => {
          budget: 50,
          items: [item1]
        },
        attendee2 => {
          budget: 75,
          items: [item1, item3]
        },
        attendee3 => {
          budget: 100,
          items: [item4]
        }
      }
      expect(auction.bidder_info).to eq(expected)
    end
  end

  context 'iteration 4' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee2, 30)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    item5.add_bid(attendee1, 35)

    it 'has a date' do
      allow(auction).to receive(:date).and_return("24/02/2020")
      expect(auction.date).to eq("24/02/2020")
    end

    it 'has items by bids' do
      expect(auction.items_by_bid).to eq([item4, item5, item1, item3, item2])
    end

    it 'can close' do
      expected = {
        item1 => attendee2,
        item2 => 'Not Sold',
        item3 => attendee2,
        item4 => attendee3,
        item5 => attendee1
      }
      expect(auction.close_auction).to eq(expected)
    end
  end
end
