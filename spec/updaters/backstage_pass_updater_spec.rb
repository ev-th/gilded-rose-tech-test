require 'updaters/backstage_pass_updater'
require 'item'

describe BackstagePassUpdater do
  let(:updater) { described_class.new }
  
  describe '#update_sell_in' do
    it "reduces item's sell_in by 1" do
      item = Item.new('item', 3, 5)
      updater.update_sell_in(item)  

      expect(item.sell_in).to eq 2
    end
  end

  describe '#update_quality' do
    context 'when the sell_in of the item is more than 10' do
      it 'increases the quality of the item by 1' do
        item = Item.new('item', 11, 13)
        updater.update_quality(item)

        expect(item.quality).to eq 14
      end
    end
    
    context 'when the sell_in of the item is 10' do
      it 'increases the quality of the item by 2' do
        item = Item.new('item', 10, 13)
        updater.update_quality(item)

        expect(item.quality).to eq 15
      end
    end

    context 'when the sell_in of the item is between 6 and 10' do
      it 'increases the quality of the item by 2' do
        item = Item.new('item', 6, 13)
        updater.update_quality(item)

        expect(item.quality).to eq 15
      end
    end

    context 'when the sell_in of the item is 5' do
      it 'increases the quality of the item by 3' do
        item = Item.new('item', 5, 10)
        updater.update_quality(item)

        expect(item.quality).to eq 13
      end
    end

    context 'when the sell_in of the item is 1' do
      it 'increases the quality of the item by 3' do
        item = Item.new('item', 1, 1)
        updater.update_quality(item)

        expect(item.quality).to eq 4
      end
    end

    context 'when the sell_in of the item is 0' do
      it 'changes the quality to 0' do
        item = Item.new('item', 0, 10)
        updater.update_quality(item)

        expect(item.quality).to eq 0
      end
    end

    context 'when the sell_in of the item is negative' do
      it 'changes the quality to 0' do
        item = Item.new('item', -1, 10)
        updater.update_quality(item)

        expect(item.quality).to eq 0
      end
    end

    context 'when the quality is 50' do
      it 'makes no change to quality' do
        item = Item.new('item', 15, 50)
        updater.update_quality(item)

        expect(item.quality).to eq 50
      end
    end

    context 'when the quality is less than 50 but could raise past 50' do
      it 'does not increase quality past 50' do
        item = Item.new('item', 3, 49)
        updater.update_quality(item)

        expect(item.quality).to eq 50
      end
    end
  end
end
