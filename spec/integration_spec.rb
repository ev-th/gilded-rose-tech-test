require 'gilded_rose'
require 'item'

describe 'integration' do
  describe 'GildedRose#update_quality' do
    context 'for standard items' do
      it 'reduces sell_by and quality by 1' do
        item = Item.new('standard_item', 10, 20)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.to_s).to eq 'standard_item, 9, 19'
      end
      
      it 'reduces quality twice as fast once sell by date is passed' do
        item = Item.new('old_item', 0, 15)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.to_s).to eq 'old_item, -1, 13'
      end
      
      it 'never reduces quality past 0' do
        item = Item.new('garbage_item', -1, 1)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.to_s).to eq 'garbage_item, -2, 0'
      end
    end
    
    context "For 'Aged Brie'" do
      let(:item) { Item.new('Aged Brie', 20, 49) }

      it 'increases quality by 1 and decreases sell_by by 1' do
        item = Item.new('Aged Brie', 20, 49)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.to_s).to eq 'Aged Brie, 19, 50'
      end

      it 'cannot increase quality above 50' do
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        gilded_rose.update_quality
        expect(item.to_s).to eq 'Aged Brie, 18, 50'
      end
    end
    
    context "For 'Sulfuras'" do
      it 'never decreases quality or sell by' do
        item = Item.new('Sulfuras, Hand of Ragnaros', 30, 40)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.to_s).to eq 'Sulfuras, Hand of Ragnaros, 30, 40'
      end
    end
    
    context 'For Backstage passes' do
      let(:backstage_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 13) }
      let(:valuable_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 48) }

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
        pass = Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 40)
        gilded_rose = GildedRose.new([pass])
        gilded_rose.update_quality
        expect(pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, -1, 0'
      end

      it 'cannot increase quality above 50' do
        gilded_rose = GildedRose.new([valuable_pass])
        gilded_rose.update_quality
        gilded_rose.update_quality
        expect(valuable_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 3, 50'
      end

      it 'if quality tries to increase by 2 from 49, it will stop at 50' do
        pass = Item.new('Backstage passes to a TAFKAL80ETC concert', 7, 49)
        gilded_rose = GildedRose.new([pass])
        gilded_rose.update_quality
        expect(pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 6, 50'
      end

      it 'if quality tries to increase by 3 from 48, it will stop at 50' do
        pass = Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 48)
        gilded_rose = GildedRose.new([pass])
        gilded_rose.update_quality
        expect(pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 2, 50'
      end
    end

    context 'for Conjured Item' do
      context 'when not out of date' do
        it 'reduces sell_by by 1 and quality by 2' do
          conjured_item = Item.new('Conjured Item', 5, 15)
          gilded_rose = GildedRose.new([conjured_item])
          gilded_rose.update_quality
          expect(conjured_item.to_s).to eq 'Conjured Item, 4, 13'
        end 
      end

      context 'when out of date' do
        it 'reduces sell_by by 1 and quality by 4' do
          conjured_item = Item.new('Conjured Item', -2, 15)
          gilded_rose = GildedRose.new([conjured_item])
          gilded_rose.update_quality
          expect(conjured_item.to_s).to eq 'Conjured Item, -3, 11'
        end 
      end
      
      it 'will not reduct quality below 0' do
        conjured_item = Item.new('Conjured Item', -2, 3)
        gilded_rose = GildedRose.new([conjured_item])
        gilded_rose.update_quality
        expect(conjured_item.to_s).to eq 'Conjured Item, -3, 0'
      end
    end

    it 'updates all the products in the items list' do
      standard_item = Item.new('standard_item', 10, 20)
      aged_brie = Item.new('Aged Brie', 20, 49)
      sulfuras = Item.new('Sulfuras, Hand of Ragnaros', 30, 40)
      backstage_pass = Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 13)
      conjured_item = Item.new('Conjured Item', 10, 13)

      gilded_rose = GildedRose.new(
        [standard_item, aged_brie, sulfuras, backstage_pass, conjured_item]
      )
      gilded_rose.update_quality

      expect(standard_item.to_s).to eq 'standard_item, 9, 19'
      expect(aged_brie.to_s).to eq 'Aged Brie, 19, 50'
      expect(sulfuras.to_s).to eq 'Sulfuras, Hand of Ragnaros, 30, 40'
      expect(backstage_pass.to_s).to eq 'Backstage passes to a TAFKAL80ETC concert, 10, 14'
      expect(conjured_item.to_s).to eq 'Conjured Item, 9, 11'
    end
  end
end