class Item
  attr_reader :name, :bids, :open_bidding

  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @open_bidding = true
  end

  def add_bid(attendee, amount)
    @bids[attendee] += amount if @open_bidding
  end

  def current_high_bid
    @bids.max_by do |person, bid|
      bid
    end&.last
  end

  def close_bidding
    @open_bidding = false
  end

  def sell
    bids_by_order.map do |person, bid|
      if person.can_buy?(bid)
        person.buy(bid)
        return person
      end
    end
  end

  def bids_by_order
    @bids.sort_by do |bid|
      bid.last
    end.reverse.to_h
  end
end
