require "spec_helper"

RSpec.describe Money do
  let(:money) {Money.new(amount: amount)}

  describe '#money.amount' do
    subject { money.amount }

    context '金額が100円のとき' do
      let(:amount) { 100 }
      it { is_expected.to eq 100 }
    end

    context '金額が500円のとき' do
      let(:amount) { 500 }
      it { is_expected.to eq 500 }
    end
  end

  describe '#money' do
    subject {money}

    context '全く同じインスタンスが作られたとき' do
      let(:amount) { 100 }
      it { is_expected.to eq Money.new(amount: 100) }
    end

    context '違うインスタンスが作られた時' do
      let(:amount) { 100 }
      it { is_expected.not_to eq Money.new(amount: 150)}
    end
  end

end
