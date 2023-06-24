require 'updater_repo'

class GildedRose
  def initialize(items, updater_repo = UpdaterRepo)
    @items = items
    @updaters = updater_repo.updaters
  end

  def update_quality()
    @items.each do |item|
      updater = @updaters[item.name]
      updater.update_item(item)
    end
  end
end
