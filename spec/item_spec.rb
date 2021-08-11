require './lib/item'
require './lib/attendee'

RSpec.describe Item do
  context 'initialize' do
    item1 = Item.new('Chalkware Piggy Bank')

    it 'exists' do
      expect(item1).to be_a(Item)
    end

    it 'has attributes' do
      expect(item1.name).to eq('Chalkware Piggy Bank')
      expect(item1.bids).to eq({})
    end
  end

  context 'bid adding' do
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')

    item1 = Item.new('Chalkware Piggy Bank')

    it 'can add a bid' do
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expected = {
        attendee2 => 20,
        attendee1 => 22
      }
      expect(item1.bids).to eq(expected)

      expect(item1.current_high_bid).to eq(22)
    end
  end
end
