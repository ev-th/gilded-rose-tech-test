# frozen_string_literal: true

require_relative 'item_updater'

class ConjuredItemUpdater < ItemUpdater
  private

  def reduce_quality(item)
    item.quality -= 1 if item.quality.positive?
    item.quality -= 1 if item.quality.positive?
  end
end
