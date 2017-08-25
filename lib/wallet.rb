require 'money'

class Wallet
  attr_accessor :money, :sum_of_money
  def initialize(money:)
    @money = money
    @sum_of_money = money.amount
  end  
end
