require "spec_helper"

RSpec.describe Money do
  let(:money) {Money.new(price: price)}

  describe '#money' do
    subject { money.price }

    context '金額が100円のとき' do
      let(:price) { 100 }
      it { is_expected.to eq 100 }
    end

    context '金額が500円のとき' do
      let(:price) { 500 }
      it { is_expected.to eq 500 }
    end
  end
end
