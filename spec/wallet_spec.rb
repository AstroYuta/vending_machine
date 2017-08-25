require "spec_helper"
require "wallet"
require "money"

RSpec.describe Wallet do
  let(:wallet) { Wallet.new(money: Money.new(amount: amount)) }

  describe '#sum_of_money' do
    subject { wallet.sum_of_money }
    let(:amount) { 1000 }

    context '初めに1000円入っている時' do
      it {is_expected.to eq 1000}
    end

    context '初めに1000円入っていて、そこに500円追加するとき' do 
      it { expect(wallet.add(Money.new(amount: 500)).sum_of_money).to eq 1500 }
    end

    context '初めに1000円入っていて、そこから500円取り出すとき' do 
      it { expect(wallet.remove(Money.new(amount: 500)).sum_of_money).to eq 500 }
    end


  end

end