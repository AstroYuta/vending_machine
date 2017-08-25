require 'money'

class Wallet
  attr_accessor :money, :sum_of_money
  def initialize(money:)
    @money = money
    @sum_of_money = money.amount
  end

  def add(money)
    self.sum_of_money += money.amount
    return self
  end

  def remove(money)
    self.sum_of_money -= money.amount
    return self
  end

end
