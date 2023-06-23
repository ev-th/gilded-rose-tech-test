require 'item_updater'
require 'aged_brie_updater'
require 'sulfuras_updater'
require 'backstage_pass_updater'

class GildedRose
  def initialize(items)
    @items = items
    @updater = ItemUpdater.new
    @aged_brie_updater = AgedBrieUpdater.new
    @sulfuras_updater = SulfurasUpdater.new
    @backstage_pass_updater = BackstagePassUpdater.new
  end

  def update_quality()
    @items.each do |item|
      if item.name =='Sulfuras, Hand of Ragnaros'
        @sulfuras_updater.update_quality(item)
        @sulfuras_updater.update_sell_by(item)
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        @backstage_pass_updater.update_quality(item)
        @backstage_pass_updater.update_sell_by(item)
      elsif item.name == 'Aged Brie'
        @aged_brie_updater.update_quality(item)
        @aged_brie_updater.update_sell_by(item)
      else
        @updater.update_quality(item)
        @updater.update_sell_by(item)
      end
    end
  end
end
