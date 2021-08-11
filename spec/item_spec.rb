require './lib/item'

RSpec.describe Item do
  context 'initialize' do
    item1 = Item.new('Chalkware Piggy Bank')

    it 'exists' do
      expect(item1).to be_a(Item)
    end

    it 'has attributes' do
      expect(item1.name).to eq('Chalkware Piggy Bank')
    end
  end
end
