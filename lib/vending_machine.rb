require "vending_machine/version"
require "product"
require "money"
require "wallet"

class Machine
  attr_accessor :product, :money
  def initialize(product:, money:)
    @product = product
    @money = money
  end

  def calculate_inserted_money
    self.money.amount
  end

end
