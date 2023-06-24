require 'updaters/sulfuras_updater'
require 'item'

describe SulfurasUpdater do
  let(:updater) { described_class.new }

  let(:item) { Item.new('item', 3, 49)}

  describe '#update_sell_in' do
    it "does not change the sell_in of the item" do
      updater.update_sell_in(item)  
      expect(item.sell_in).to eq 3
    end
  end

  describe '#update_quality' do
    it 'does not change the quality of the item' do
      updater.update_quality(item)  
      expect(item.quality).to eq 49
    end
  end
end
