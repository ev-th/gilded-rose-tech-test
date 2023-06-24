# frozen_string_literal: true

require 'updaters'

class GildedRose
  def initialize(items, updaters = UPDATERS)
    @items = items
    @updaters = updaters
  end

  def update_quality
    @items.each do |item|
      updater = @updaters[item.name]
      updater.update_item(item)
    end
  end
end
