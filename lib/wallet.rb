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

  def take_out(money)
    if self.sum_of_money < money.amount
      raise ArgumentError
    else
      self.sum_of_money -= money.amount
      return self
    end
  end

  def merge(other_wallet)
    self.sum_of_money += other_wallet.sum_of_money
    return self
  end
end
