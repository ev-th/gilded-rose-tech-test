require 'updaters/aged_brie_updater'
require 'item'

describe AgedBrieUpdater do
  let(:updater) { described_class.new }

  let(:item) { Item.new('item', 3, 49)}

  describe '#update_sell_in' do
    it "reduces item's sell_in by 1" do
      updater.update_sell_in(item)  
      expect(item.sell_in).to eq 2
    end
  end

  describe '#update_quality' do
    context 'when quality is less than 50' do
      it 'increases the quality by 1' do
        updater.update_quality(item)  
        expect(item.quality).to eq 50
      end
    end

    context 'when quality is 50 or more' do
      it 'does not increase the quality' do
        updater.update_quality(item)
        updater.update_quality(item)
        expect(item.quality).to eq 50
      end
    end
  end
end
