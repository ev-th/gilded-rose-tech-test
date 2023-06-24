require 'updater_repo'

class GildedRose
  def initialize(items, updaters = UpdaterRepo)
    @items = items
    @standard_updater = updaters.default
    @special_updaters = updaters.special
  end

  def update_quality()
    @items.each do |item|
      updater = select_updater(item)
      update_item(item, updater) 
    end
  end
  
  def select_updater(item)
    @special_updaters.fetch(item.name, @standard_updater)
  end

  def update_item(item, updater)
    updater.update_quality(item)
    updater.update_sell_in(item)
  end
end
