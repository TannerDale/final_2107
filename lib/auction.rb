class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    items_with_bids.sum do |item|
      item.current_high_bid
    end
  end

  def items_with_bids
    @items.find_all do |item|
      item.bids != {}
    end
  end

  def bidders
    persons_with_bids.map do |person|
      person.name
    end
  end

  def persons_with_bids
    @items.flat_map do |item|
      item.bids.map do |person, bid|
        person
      end
    end.uniq
  end

  def bidder_info
    persons_with_bids.map do |person|
      items = @items.select do |item|
        item.bids.has_key?(person)
      end
      info = { budget: person.budget, items: items}

      [person, info]
    end.to_h
  end
end
