class Money
  attr_reader :amount
  def initialize(amount:)
    @amount = amount
    if @amount < 0
      raise ArgumentError
    end
  end

  def ==(other_money)
    other_money.is_a?(Money) &&
    self.amount == other_money.amount
  end

  def plus(other_money)
    amount_new = self.amount + other_money.amount
    new_money = Money.new(amount: amount_new)
    return new_money
  end

  def minus(other_money)
    amount_new = self.amount - other_money.amount
    new_money = Money.new(amount: amount_new)
    return new_money
  end
end