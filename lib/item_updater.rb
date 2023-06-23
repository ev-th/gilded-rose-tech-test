class ItemUpdater
  def update_item(item)
    update_quality(item)
    update_sell_by(item)
  end

  private

  def update_sell_by(item)
    item.sell_in = item.sell_in - 1
  end
  
  def update_quality(item)
    reduce_quality(item)
    reduce_quality(item) if item.sell_in <= 0
  end

  def reduce_quality(item)
    item.quality = item.quality - 1 if item.quality > 0
  end
end
