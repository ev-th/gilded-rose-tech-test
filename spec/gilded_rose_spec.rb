require 'gilded_rose'

describe GildedRose do
  it "gets an item's corresponding Updater and uses it to update the item" do
    updater = double :updater, update_item: nil
    item = double :item, name: 'special_item'
    
    fake_repo = double :fake_repo
    allow(fake_repo).to receive(:updaters).and_return(
      {
        'special_item' => updater
      }
    )

    gilded_rose = GildedRose.new([item], fake_repo)

    expect(updater).to receive(:update_item).with(item)

    gilded_rose.update_quality
  end
  
  it "updates all items with their corresponding updater" do
    updater1 = double :updater1, update_item: nil
    updater2 = double :updater2, update_item: nil
    updater3 = double :updater3, update_item: nil

    item1 = double :item, name: 'item1'
    item2 = double :item, name: 'item2'
    item3 = double :item, name: 'item3'
    items = [item1, item2, item3]
    
    fake_repo = double :fake_repo
    allow(fake_repo).to receive(:updaters).and_return(
      {
        'item1' => updater1,
        'item2' => updater2,
        'item3' => updater3
      }
    )

    gilded_rose = GildedRose.new(items, fake_repo)

    expect(updater1).to receive(:update_item).with(item1)
    expect(updater2).to receive(:update_item).with(item2)
    expect(updater3).to receive(:update_item).with(item3)

    gilded_rose.update_quality
  end
end