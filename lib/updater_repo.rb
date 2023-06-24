# frozen_string_literal: true

require 'updaters/item_updater'
require 'updaters/aged_brie_updater'
require 'updaters/sulfuras_updater'
require 'updaters/backstage_pass_updater'
require 'updaters/conjured_item_updater'

class UpdaterRepo
  @@updaters = Hash.new(ItemUpdater.new).merge(
    {
      'Sulfuras, Hand of Ragnaros' => SulfurasUpdater.new,
      'Backstage passes to a TAFKAL80ETC concert' => BackstagePassUpdater.new,
      'Aged Brie' => AgedBrieUpdater.new,
      'Conjured Item' => ConjuredItemUpdater.new
    }
  )

  def self.updaters
    @@updaters
  end
end
