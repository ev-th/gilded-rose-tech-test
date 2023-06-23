require_relative 'item_updater'

class AgedBrieUpdater < ItemUpdater
  def update_quality(item)
    item.quality += 1 if item.quality < 50 
  end
end
