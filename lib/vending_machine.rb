require "vending_machine/version"
require "product"
require "money"
require "wallet"

class Machine
  attr_accessor :product, :money
  def initialize(product:)
    @product = product
    @money = Money.new(amount: 0)
  end

  def calculate_inserted_money
    self.money.amount
  end

  def insert_money(other_money)
    self.money += other_money
    self
  end

end
