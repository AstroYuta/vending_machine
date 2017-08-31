require "spec_helper"

RSpec.describe Product do
  let(:product) { Product.new(name: name, price: price) }
  let(:name)    { 'default name' }
  let(:price)   { Money::ZERO }

  describe '#name' do
    subject { product.name }

    context 'nameがhogeの場合' do
      let(:name) { 'hoge' }
      it { is_expected.to eq 'hoge' }
    end

    context 'nameがコーラの場合' do
      let(:name) { 'コーラ' }
      it { is_expected.to eq 'コーラ' }
    end
  end

  describe '#price' do
    context '150円の場合' do
      let(:price) { Money.new(amount: 150) }

      subject { product.price }

      it { expect(subject.amount).to eq 150 }
    end

    context '-100円の場合' do
      let(:price) { Money.new(amount: -100) }

      subject { product.price }

      it { expect {subject}.to raise_error ArgumentError }
    end

  end
end
