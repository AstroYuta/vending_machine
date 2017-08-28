require 'money'

class Wallet
  attr_accessor :money
  def initialize(money:)
    @money = money
  end

  def add(money)
    self.money += money
    return self
  end

  def take_out(money)
    if self.money.amount < money.amount
      raise ArgumentError
    end
    self.money -= money
    return self
  end

  def merge(other_wallet)
    self.money += other_wallet.money
    return self
  end

  def sum_of_money
    self.money.amount
  end
end
