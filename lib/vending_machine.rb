require "vending_machine/version"
require "product"
require "money"
require "wallet"

class ShortOfMoneyError < StandardError; end

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

  def add_having_product(*other_product)
    other_product.each do |adding_product|
      self.having_product[adding_product.name] = adding_product
    end
    self
  end

  def remove_having_product(*name_of_product)
    name_of_product.each do |name_of_removing_product|
      self.having_product.delete(name_of_removing_product)
    end
    self
  end
  
  def buy(name_of_product)
    if self.having_product.has_key?(name_of_product) == false
      raise ArgumentError
    end
    begin
      self.inserted_money -= self.having_product[name_of_product].price
    rescue
      raise ShortOfMoneyError
    end
    self.buyed_product[name_of_product] = self.having_product[name_of_product]
    self
  end
end