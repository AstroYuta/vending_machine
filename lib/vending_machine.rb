require "vending_machine/version"
require "product"
require "money"
require "wallet"

class Vendingmachine
  attr_accessor :having_product, :buyed_product, :inserted_money
  def initialize
    @having_product = {}
    @buyed_product = {}
    @inserted_money = Money::ZERO
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

  def add_having_product(other_product)
    self.having_product[other_product.name] = other_product
    self
  end

  def remove_having_product(name_of_product)
    self.having_product.delete(name_of_product)
    self
  end
  
  def buy(name_of_product)
    self.inserted_money -= self.having_product[name_of_product].price
    self.buyed_product[name_of_product] = self.having_product[name_of_product]
    self
  end
end