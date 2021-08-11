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
      expect(item1.open_bidding).to be(true)
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

  context 'bid closing' do
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')

    item1 = Item.new('Chalkware Piggy Bank')

    it 'it can close bids' do
      item1.add_bid(attendee1, 50)

      item1.close_bidding

      expect(item1.open_bidding).to be(false)

      item1.add_bid(attendee2, 50)

      expect(item1.bids).to eq({attendee1 => 50})
    end
  end

  it 'can sell and item' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.sell).to eq(attendee1)
  end

  it 'has bids by order' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.bids_by_order).to eq({
      attendee1 => 22,
      attendee2 => 20
    })
  end

  it 'can change who to sell to' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee3 = Attendee.new(name: 'Megan', budget: '$20')
    attendee4 = Attendee.new(name: 'Bob', budget: '$75')
    item1.add_bid(attendee3, 20)
    item1.add_bid(attendee4, 22)

    expect(item1.sell).to eq(attendee4)
  end
end
