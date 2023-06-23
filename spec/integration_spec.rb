require 'gilded_rose'
require 'item'

describe 'integration' do
  let(:standard_item) { Item.new('standard_item', 10, 20) }
  let(:old_item) { Item.new('old_item', 0, 15) }
  let(:garbage_item) { Item.new('garbage_item', 10, 0) }
  let(:quality_item) { Item.new('quality_item', 10, 51) }
  let(:aged_brie) { Item.new('Aged Brie', 20, 49) }

  describe 'GildedRose#update_quality' do
    context 'for standard items' do
      it 'reduces sell_by and quality by 1' do
        gilded_rose = GildedRose.new([standard_item])
        gilded_rose.update_quality
        expect(standard_item.to_s).to eq 'standard_item, 9, 19'
      end
      
      it 'reduces quality twice as fast once sell by date is passed' do
        gilded_rose = GildedRose.new([old_item])
        gilded_rose.update_quality
        expect(old_item.to_s).to eq 'old_item, -1, 13'
      end
      
      it 'never reduces quality past 0' do
        gilded_rose = GildedRose.new([garbage_item])
        gilded_rose.update_quality
        expect(garbage_item.to_s).to eq 'garbage_item, 9, 0'
      end
    end
    
    context "For 'Aged Brie'" do
      it 'increases quality by 1 and decreases sell_by by 1' do
        gilded_rose = GildedRose.new([aged_brie])
        gilded_rose.update_quality
        expect(aged_brie.to_s).to eq 'Aged Brie, 19, 50'
      end

      it 'cannot increase quality above 50' do
        gilded_rose = GildedRose.new([aged_brie])
        gilded_rose.update_quality
        gilded_rose.update_quality
        expect(aged_brie.to_s).to eq 'Aged Brie, 18, 50'
      end
    end
  end
end


# Once the sell by date has passed, Quality degrades twice as fast
# The Quality of an item is never negative
# The Quality of an item is never more than 50
# “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
# “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert