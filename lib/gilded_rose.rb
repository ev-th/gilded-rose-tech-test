require 'updater_repo'

class GildedRose
  def initialize(items, updaters = UpdaterRepo)
    @items = items
    @standard_updater = updaters.default
    @special_updaters = updaters.special
  end

  def update_quality
    @items.each { |item| select_updater(item).update_item(item) }
  end

  private
  
  def select_updater(item)
    @special_updaters.fetch(item.name, @standard_updater)
  end
end
