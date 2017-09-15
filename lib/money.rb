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

  def +(other_money)
    Money.new(amount: self.amount + other_money.amount)
  end

  def -(other_money)
    Money.new(amount: self.amount - other_money.amount)
  end
end

Money::ZERO = Money.new(amount: 0)
