require "spec_helper"
require "wallet"

RSpec.describe Wallet do
  let(:wallet) { Wallet.new(money: Money.new(amount: default_money_amount)) }

  describe '#sum_of_money' do
    subject { wallet.sum_of_money }
    let(:default_money_amount) { 1000 }

    context '初めに1000円入っている時' do
      it {is_expected.to eq 1000}
    end

    context '初めに1000円入っていて、そこに500円追加するとき' do 
      it { expect(wallet.add(Money.new(amount: 500)).sum_of_money).to eq 1500 }
    end

    context '初めに1000円入っていて、そこから500円取り出すとき' do 
      it { expect(wallet.take_out(Money.new(amount: 500)).sum_of_money).to eq 500 }
    end

    context '初めに1000円入っていて、そこから5000円取り出すとき' do
      it { expect { wallet.take_out(Money.new(amount: 5000)) }.to raise_error(ArgumentError) }

    end


    context '1000円入っている財布と1000入っている財布を統合したとき' do
      it { expect(wallet.merge(Wallet.new(money: Money.new(amount: 1000))).sum_of_money).to eq 2000 }

    end

  end

end