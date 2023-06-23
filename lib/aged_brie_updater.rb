require_relative 'item_updater'

class AgedBrieUpdater < ItemUpdater
  def update_sell_by(item)
    # Standard, Brie and Backstage pass: Reduce sell by
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end

    if item.sell_in < 0
      # Standard, Pass, Sulfuras
      if item.name != "Aged Brie"
        # Standard, Sulfuras
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.quality > 0
            # Standard
            if item.name != "Sulfuras, Hand of Ragnaros"
              # Out of date products extra quality loss when > 0
              item.quality = item.quality - 1
            end
          end

        # Pass
        else
          item.quality = item.quality - item.quality
        end

      # Brie
      else
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end
  end

  def update_quality(item)
    # Standard items and Sulfuras
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      if item.quality > 0

        # Standard items
        if item.name != "Sulfuras, Hand of Ragnaros"
          # Reduce quality when > 0
          item.quality = item.quality - 1
        end
      end

    # Brie and Pass
    else
      # Increase quality if < 50
      if item.quality < 50
        item.quality = item.quality + 1
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          # add backstage pass extra quality
          if item.sell_in < 11
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
          # add backstage pass extra extra quality
          if item.sell_in < 6
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
        end
      end
    end
  end
end
