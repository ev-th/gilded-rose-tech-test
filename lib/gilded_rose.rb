require 'quality_updater'
require 'special_item_quality_updater'

class GildedRose
  def initialize(items)
    @items = items
    @updater = QualityUpdater.new
    @special_updater = SpecialItemQualityUpdater.new
    @special_items = [
      'Sulfuras, Hand of Ragnaros',
      'Backstage passes to a TAFKAL80ETC concert',
      'Aged Brie'
    ]
  end

  def update_quality()
    @items.each do |item|
      if @special_items.include?(item.name)
        @special_updater.update_item(item)
      else
        @updater.update_item(item)
      end
    end
  end
end
