require 'updaters'

class GildedRose
  def initialize(items, updaters = Updaters.new)
    @items = items
    @standard_updater = updaters.default_updater
    @special_updaters = updaters.special_updaters
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
