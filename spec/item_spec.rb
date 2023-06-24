# frozen_string_literal: true

require 'item'

RSpec.describe Item do
  it 'has a string representation with name, sell_in, and quality' do
    item = Item.new('test_item', 10, 20)
    expect(item.to_s).to eq 'test_item, 10, 20'
  end
end
