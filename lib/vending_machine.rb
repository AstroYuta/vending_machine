require "vending_machine/version"
require "product"
require "money"
require "wallet"

class ShortOfMoneyError < StandardError; end

class VendingMachine
  attr_accessor :having_product, :buyed_product, :inserted_money, :stock
  def initialize
    #having_productはproduct.nameをkeyとし、productをvalueとしてもつ
    @having_product = Hash.new { |hash, key| hash[key] = [] }
    #buyed_productもhaving_productと構造は同じ
    @buyed_product = Hash.new { |hash, key| hash[key] = [] }
    #初期状態のVendingMachine内のお金は0円
    @inserted_money = Money::ZERO
    #在庫に関する情報stockはproductをkeyとし、個数をvalueとしてもつ
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
      if adding_product[:number_of_product] < 0
        raise ArgumentError
      end
      self.having_product[adding_product[:product].name] = adding_product[:product]
      self.stock[adding_product[:product]] += adding_product[:number_of_product]
    end
    self
  end

  def remove_having_product(*removing_products)
    removing_products.each do |removing_product|
      if removing_product[:number_of_removing_product] < 0
        raise ArgumentError
      end
      self.stock[removing_product[:product]] -= removing_product[:number_of_removing_product]
      if self.stock[removing_product[:product]] < 0
        raise ArgumentError
      end
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
