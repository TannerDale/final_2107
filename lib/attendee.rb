class Attendee
  attr_reader :name, :budget

  def initialize(params)
    @name = params[:name]
    @budget = params[:budget].delete('$').to_i
  end

  def can_buy?(bid)
    @budget >= bid
  end

  def buy(amount)
    @budget -= amount
  end
end
