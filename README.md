# Gilded Rose Tech Test

A practice tech test for week 10 of Makers Academy. A challenge to add a new feature to an existing codebase that is poorly designed. To see the original specifications, see the bottom of the README.

## Setup

Clone the repository, install dependencies, and run tests:
```shell
git clone https://github.com/ev-th/gilded-rose-tech-test.git
cd gilded-rose-tech-test
bundle install
rspec
```

## Usage

You can interact with with program in IRB
```ruby
# Import the GildedRose and Item classes.
require_relative 'lib/gilded_rose'
require_relative 'lib/item'

# Initialize some items.
items = [
    Item.new('standard_item', 10, 20),
    Item.new('Aged Brie', 20, 49),
    Item.new('Sulfuras, Hand of Ragnaros', 30, 40),
    Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 13),
    Item.new('Conjured Item', 10, 13)
]

# Initialize GildedRose with the items.
gilded_rose = GildedRose.new(items)

# Update the quality and sell_in time of all the Gilded Rose's items
# based on the rules set for the item's name.
gilded_rose.update_quality
```

## Demonstration
![repl demonstration](./demo.png)

## Creating Custom Item Rules

You can expand the program by adding your own custom rules.
1. Within lib/updaters/ create a new class that inherits from ItemUpdater.
2. Include a new #update_sell_in method and/or #update_quality method to change the way the items are updated as one day passes.
3. In lib/updaters.rb import your custom updater class and add it to the UPDATERS hash. For the key, use the name of the item that will use that updater.



The following is copied from the README of the original tech test specifications:

# Gilded rose tech test

This is a well known kata developed by [Terry Hughes](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/). This is commonly used as a tech test to assess a candidate's ability to read, refactor and extend legacy code.

Here is the text of the kata:

*"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a `SellIn` value which denotes the number of days we have to sell the item. All items have a Quality value which denotes how valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- “Aged Brie” actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
- “Backstage passes”, like aged brie, increases in Quality as it’s `SellIn` value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

* “Conjured” items degrade in Quality twice as fast as normal items

Feel free to make any changes to the `UpdateQuality` method and add any new code as long as everything still works correctly. However, do not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership (you can make the `UpdateQuality` method and Items property static if you like, we’ll cover for you)."*

## The brief:

Choose [legacy code](https://github.com/emilybache/GildedRose-Refactoring-Kata) (translated by Emily Bache) in the language of your choice. The aim is to practice good design in the language of your choice. Refactor the code in such a way that adding the new "conjured" functionality is easy.

You don't need to clone the repo if you don't want to. Feel free to copy [the ruby code](https://github.com/emilybache/GildedRose-Refactoring-Kata/blob/main/ruby/gilded_rose.rb) into a new folder and write your tests from scratch.

HINT: Test first FTW!