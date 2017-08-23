class Money
  attr_reader :amount
  def initialize(amount:)
    @amount = amount
  end

  def ==(other_money)
    self.amount == other_money.amount
  end
end