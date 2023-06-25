# frozen_string_literal: true

require_relative 'updaters/item_updater'
require_relative 'updaters/aged_brie_updater'
require_relative 'updaters/sulfuras_updater'
require_relative 'updaters/backstage_pass_updater'
require_relative 'updaters/conjured_item_updater'

UPDATERS = Hash.new(ItemUpdater.new).merge(
  {
    'Sulfuras, Hand of Ragnaros' => SulfurasUpdater.new,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassUpdater.new,
    'Aged Brie' => AgedBrieUpdater.new,
    'Conjured Item' => ConjuredItemUpdater.new
  }
)
