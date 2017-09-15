require "vending_machine/version"
require "product"
require "money"
require "wallet"

class ShortOfMoneyError < StandardError; end
class ShortOfStockError < StandardError; end

class VendingMachine
  attr_accessor :having_product, :buyed_product, :inserted_money, :stock
  def initialize
    @having_product = Hash.new { |hash, key| hash[key] = [] }
    @buyed_product = Hash.new { |hash, key| hash[key] = [] }
    @inserted_money = Money::ZERO
    @stock = Hash.new(0)
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

  def add_having_product(*other_products)
    other_products.each do |adding_product|
      if adding_product[:number_of_added_product] < 0
        raise ArgumentError
      end
      self.having_product[adding_product[:product].name] = adding_product[:product]
      self.stock[adding_product[:product]] += adding_product[:number_of_added_product]
    end
    self
  end

  def remove_having_product(*removing_products)
    removing_products.each do |removing_product|
      if removing_product[:number_of_removing_product] < 0
        raise ArgumentError
      elsif self.stock[removing_product[:product]] < removing_product[:number_of_removing_product]
        raise ShortOfStockError
      else
        self.stock[removing_product[:product]] -= removing_product[:number_of_removing_product]
      end
    end
    self
  end
  
  def buy(buyed_product)
    if self.having_product.has_key?(buyed_product.name) == false
      raise ArgumentError
    end
    
    begin
      self.inserted_money -= self.having_product[buyed_product.name].price
    rescue
      raise ShortOfMoneyError
    end
    #在庫のある場合だけ、stockを一つ減らす
    if self.stock[buyed_product] < 1
      raise ShortOfStockError
    else
      self.stock[buyed_product] -= 1
    end
    #buyed_productに購入したproductを渡す
    self.buyed_product[buyed_product.name] = self.having_product[buyed_product.name]
    self
  end
end
