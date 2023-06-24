# frozen_string_literal: true

require_relative 'item_updater'

class BackstagePassUpdater < ItemUpdater
  def update_quality(item)
    increase_quality(item)
    ensure_maximum(item)
    ensure_not_past_sell_by(item)
  end

  def increase_quality(item)
    item.quality += 1
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
  end

  def ensure_maximum(item)
    item.quality = 50 if item.quality > 50
  end

  def ensure_not_past_sell_by(item)
    item.quality = 0 if item.sell_in <= 0
  end
end
