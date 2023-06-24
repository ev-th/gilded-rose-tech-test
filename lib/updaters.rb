require 'item_updater'
require 'aged_brie_updater'
require 'sulfuras_updater'
require 'backstage_pass_updater'

class Updaters
  attr_reader :default_updater, :special_updaters

  def initialize
    @default_updater = ItemUpdater.new
    @special_updaters = {
      'Sulfuras, Hand of Ragnaros' => SulfurasUpdater.new,
      'Backstage passes to a TAFKAL80ETC concert' => BackstagePassUpdater.new,
      'Aged Brie' => AgedBrieUpdater.new
    }
  end
end
