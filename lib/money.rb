class Money
  attr_reader :amount
  def initialize(amount:)
    @amount = amount
  end

  def ==(other_money)
    other_money.is_a?(Money) &&
    self.amount == other_money.amount
  end
end