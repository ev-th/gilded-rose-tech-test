require 'updaters/item_updater'
require 'updaters/aged_brie_updater'
require 'updaters/sulfuras_updater'
require 'updaters/backstage_pass_updater'

class UpdaterRepo
  @@default_updater = ItemUpdater.new
  @@special_updaters = {
    'Sulfuras, Hand of Ragnaros' => SulfurasUpdater.new,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassUpdater.new,
    'Aged Brie' => AgedBrieUpdater.new
  }

  def self.default
    @@default_updater
  end

  def self.special
    @@special_updaters
  end
end
