require './lib/attendee'

RSpec.describe Attendee do
  context 'initialize' do
    attendee = Attendee.new(name: 'Megan', budget: '$50')

    it 'exists' do
      expect(attendee).to be_a(Attendee)
    end

    it 'has attributes' do
      expect(attendee.name).to eq('Megan')
      expect(attendee.budget).to eq(50)
    end
  end

  context 'buying' do
    attendee = Attendee.new(name: 'Megan', budget: '$50')

    it 'can buy' do
      expect(attendee.can_buy?(40)).to be(true)

      attendee.buy(40)

      expect(attendee.can_buy?(40)).to be(false)
      expect(attendee.budget).to eq(10)
    end
  end
end
