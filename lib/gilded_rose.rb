require 'quality_updater'

class GildedRose
  def initialize(items)
    @items = items
    @updater = QualityUpdater.new
  end

  def update_quality()
    @items.each do |item|
      @updater.update_item(item)
    end
  end
end
