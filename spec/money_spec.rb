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
    subject { money == Money.new(amount:100) }

    context '全く同じインスタンスが作られたとき' do
      let(:amount) { 100 }
      it { is_expected.to be_truthy }
    end
  end

  describe '#==' do
    subject { money == Money.new(amount:150) }

    context 'moneyの値の違うインスタンスが作られたとき' do
      let(:amount) { 100 }
      it { is_expected.to be_falsey }
    end
  end

  describe '#==' do
    subject { money == other }

    shared_examples '==' do |x|
      context "#{x.class.to_s}と比較されたとき" do
        let(:other) { x }
        let(:amount) { 100 }
        it { is_expected.to be_falsey }
      end
    end

    include_examples '==', 100
    include_examples '==', 100.01
    include_examples '==', '100'

  end
end
