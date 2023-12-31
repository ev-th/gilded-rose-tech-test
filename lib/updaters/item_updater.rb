# frozen_string_literal: true

class ItemUpdater
  def update_item(item)
    update_quality(item)
    update_sell_in(item)
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def update_quality(item)
    reduce_quality(item)
    reduce_quality(item) if item.sell_in <= 0
  end

  private

  def reduce_quality(item)
    item.quality -= 1 if item.quality.positive?
  end
end
