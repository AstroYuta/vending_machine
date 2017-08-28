require "vending_machine/version"
require "product"
require "money"
require "wallet"

class Machine
  attr_accessor :product, :inserted_money
  def initialize(product:)
    @product = product
    @inserted_money = Money.new(amount: 0)
  end

  def calculate_inserted_money
    self.inserted_money.amount
  end

  def insert_money(other_inserted_money)
    self.inserted_money += other_inserted_money
    self
  end

  def reset_inserted_money
    self.inserted_money = Money.new(amount: 0)
    self
  end
end
