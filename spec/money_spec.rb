require "spec_helper"

RSpec.describe Money do
  let(:money) {Money.new(amount: amount)}

  describe '#amount' do
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

  describe '#==' do
    let(:amount) { 100 }

    subject { money == other }

    context '全く同じインスタンスが作られたとき' do
      let(:other) { Money.new(amount: amount) }
      it { is_expected.to be_truthy }
    end
    context 'moneyの値の違うインスタンスが作られたとき' do
      let(:other) { Money.new(amount:  150) }
      it { is_expected.to be_falsey }
    end

    shared_examples '==' do |x|
      context "#{x.class.to_s}と比較されたとき" do
        let(:other) { x }
        it { is_expected.to be_falsey }
      end
    end

    include_examples '==', 100
    include_examples '==', 100.01
    include_examples '==', '100'
  end
end
