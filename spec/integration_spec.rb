require 'gilded_rose'
require 'item'

describe 'integration' do
  let(:standard_item) { Item.new('standard_item', 10, 20) }
  let(:old_item) { Item.new('old_item', 0, 15) }
  let(:garbage_item) { Item.new('garbage_item', 10, 0) }
  let(:quality_item) { Item.new('quality_item', 10, 51) }
  let(:aged_brie) { Item.new('Aged Brie', 20, 49) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 30, 40) }
  let(:backstage_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 13) }
  let(:valuable_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 48) }
  let(:today_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 40) }
  let(:pass_49_quality) { Item.new('Backstage passes to a TAFKAL80ETC concert', 7, 49) }
  let(:pass_48_quality) { Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 48) }

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
    
    context "For 'Sulfuras'" do
      it 'never decreases quality or sell by' do
        gilded_rose = GildedRose.new([sulfuras])
        gilded_rose.update_quality
        expect(sulfuras.to_s).to eq 'Sulfuras, Hand of Ragnaros, 30, 40'
      end
    end
    
    context 'For Backstage passes' do
      it 'increases in quality by 1 when sell_in is more than 10 days' do
        gilded_rose = GildedRose.new([backstage_pass])
        gilded_rose.update_quality
        expect(backstage_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 10, 14'
      end

      it 'increases in quality by 2 when sell_in is less than 11 days' do
        gilded_rose = GildedRose.new([backstage_pass])
        gilded_rose.update_quality
        gilded_rose.update_quality
        expect(backstage_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 9, 16'
      end

      it 'increases in quality by 3 when sell_in is less than 6 days' do
        gilded_rose = GildedRose.new([valuable_pass])
        gilded_rose.update_quality
        expect(valuable_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 4, 50'
      end

      it 'reduces quality to 0 when sell_by reduces to 0' do
        gilded_rose = GildedRose.new([today_pass])
        gilded_rose.update_quality
        expect(today_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, -1, 0'
      end

      it 'cannot increase quality above 50' do
        gilded_rose = GildedRose.new([valuable_pass])
        gilded_rose.update_quality
        gilded_rose.update_quality
        expect(valuable_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 3, 50'
      end

      it 'if quality tries to increase by 2 from 49, it will stop at 50' do
        gilded_rose = GildedRose.new([pass_49_quality])
        gilded_rose.update_quality
        expect(pass_49_quality.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 6, 50'
      end

      it 'if quality tries to increase by 3 from 48, it will stop at 50' do
        gilded_rose = GildedRose.new([pass_48_quality])
        gilded_rose.update_quality
        expect(pass_48_quality.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 2, 50'
      end
    end

    it 'updates all the products in the items list' do
      gilded_rose = GildedRose.new(
        [standard_item, aged_brie, sulfuras, backstage_pass]
      )
      gilded_rose.update_quality

      expect(standard_item.to_s).to eq 'standard_item, 9, 19'
      expect(aged_brie.to_s).to eq 'Aged Brie, 19, 50'
      expect(sulfuras.to_s).to eq 'Sulfuras, Hand of Ragnaros, 30, 40'
      expect(backstage_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 10, 14'
    end
  end
end
