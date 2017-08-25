require "spec_helper"
require "wallet"
require "money"

RSpec.describe Wallet do
  let(:wallet) { Wallet.new(money: Money.new(amount: amount)) }

  describe '#sum_of_money' do
    subject { wallet.sum_of_money }

    context '初めに1000円入っている時' do
      let(:amount) { 1000 }

      it {is_expected.to eq 1000}
    end

  end

end