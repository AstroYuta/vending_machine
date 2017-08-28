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
      before {
        wallet.add(Money.new(amount: 500))
      }
      it { is_expected.to eq 1500 }
    end

    context '初めに1000円入っていて、そこから500円取り出すとき' do
      before {
        wallet.take_out(Money.new(amount: 500))
      }
      it { is_expected.to eq 500 }
    end

    context '1000円入っている財布と1000入っている財布を統合したとき' do
      it { expect(wallet.merge(Wallet.new(money: Money.new(amount: 1000))).sum_of_money).to eq 2000 }
    end
  end

  describe '#add' do
    let(:default_money_amount) { 1000 }

    subject { wallet.add(Money.new(amount: add_money_amount)) }

    context '500円足した場合' do
      let(:add_money_amount) { 500 }
      it { expect(subject.money.amount).to eq 1500 }
    end

    context '100円足した場合' do
      let(:add_money_amount) { 100 }
      it { expect(subject.money.amount).to eq 1100 }
    end

    context '-100円足した場合' do
      let(:add_money_amount) { -100 }
      it {
        expect { subject }.to raise_error ArgumentError
      }
    end
  end

  describe '#take_out' do
    let(:default_money_amount) { 1000 }

    subject { wallet.take_out(Money.new(amount: take_out_money_amount)) }

    context '100円引いた場合' do
      let(:take_out_money_amount) { 100 }
      it { expect(subject.money.amount).to eq 900 }
    end

    context '900円引いた場合' do
      let(:take_out_money_amount) { 900 }
      it { expect(subject.money.amount).to eq 100 }
    end

    context '1100円引いた場合' do
      let(:take_out_money_amount) { 1100 }
      it {
        expect { subject }.to raise_error ArgumentError
      }
    end
  end
end
