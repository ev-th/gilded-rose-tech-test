# frozen_string_literal: true

require 'updaters/item_updater'
require 'item'

describe ItemUpdater do
  let(:updater) { described_class.new }

  describe '#update_sell_in' do
    it "reduces item's sell_in by 1" do
      item = Item.new('item', 3, 5)
      updater.update_sell_in(item)

      expect(item.sell_in).to eq 2
    end
  end

  describe '#update_quality' do
    context 'the sell in date has passed' do
      it 'reduces quality by two' do
        item = Item.new('item', -1, 5)
        updater.update_quality(item)

        expect(item.quality).to eq 3
      end

      it 'can reduce the quality to 0 but not past 0' do
        item = Item.new('item', -1, 1)
        updater.update_quality(item)

        expect(item.quality).to eq 0
      end
    end

    context 'the sell in date has not passed' do
      it 'reduces quality by one' do
        item = Item.new('item', 4, 6)
        updater.update_quality(item)

        expect(item.quality).to eq 5
      end

      it 'does not reduce the quality past 0' do
        item = Item.new('item', 4, 0)
        updater.update_quality(item)

        expect(item.quality).to eq 0
      end
    end
  end
end
