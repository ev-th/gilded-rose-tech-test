require 'item_updater'
require 'aged_brie_updater'
require 'sulfuras_updater'
require 'backstage_pass_updater'

class GildedRose
  def initialize(items)
    @items = items
    @standard_updater = ItemUpdater.new
    @special_updaters = {
      'Sulfuras, Hand of Ragnaros' => SulfurasUpdater.new,
      'Backstage passes to a TAFKAL80ETC concert' => BackstagePassUpdater.new,
      'Aged Brie' => AgedBrieUpdater.new
    }
  end

  def update_quality()
    @items.each { |item| update_item(item, select_updater(item)) }
  end
  
  def select_updater(item)
    @special_updaters.fetch(item.name, @standard_updater)
  end

  def update_item(item, updater)
    updater.update_quality(item)
    updater.update_sell_by(item)
  end
end
