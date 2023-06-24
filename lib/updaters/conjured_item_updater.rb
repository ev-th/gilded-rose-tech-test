require_relative 'item_updater'

class ConjuredItemUpdater < ItemUpdater
  private

  def reduce_quality(item)
    item.quality -= 1 if item.quality > 0
    item.quality -= 1 if item.quality > 0
  end
end