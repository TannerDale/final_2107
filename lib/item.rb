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
    end.last
  end

  def close_bidding
    @open_bidding = false
  end
end
