require 'money'

class Wallet
  attr_accessor :sum_of_money
  attr_accessor :n_of_1yen, :n_of_10yen, :n_of_50yen, :n_of_100yen, :n_of_500yen
  def initialize(n_of_1yen:, n_of_10yen:, n_of_50yen:, n_of_100yen:,
    n_of_500yen:)
    @n_of_1yen = n_of_1yen
    @n_of_10yen = n_of_10yen
    @n_of_50yen = n_of_50yen
    @n_of_100yen = n_of_100yen
    @n_of_500yen = n_of_500yen
    @sum_of_money = Money.new(amount: 1).amount * n_of_1yen + Money.new(amount: 10).amount * n_of_10yen + 
      Money.new(amount: 50).amount * n_of_50yen + Money.new(amount: 100).amount * n_of_100yen +
      Money.new(amount: 500).amount * n_of_500yen
    if (@sum_of_money < 0 || @n_of_1yen < 0 || @n_of_10yen < 0) then
      raise ArgumentError, 'invalid argument negative money'
    
    end

  end

  def merge(x)
    sum_of_money_new = self.sum_of_money + x.sum_of_money
    y = Wallet.new(sum_of_money: sum_of_money_new)
    return y
  end
end
