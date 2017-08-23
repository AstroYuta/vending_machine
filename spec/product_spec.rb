require "spec_helper"

RSpec.describe Product do
  describe '#name' do
    let(:product) { Product.new(name: 'hoge', price: 150)}

    subject { product.name }

    it { is_expected.to eq 'hoge' }

    context 'nameがコーラの場合' do
      let(:product) { Product.new(name: 'コーラ', price: 170) }
      it { is_expected.to eq 'コーラ' }
    end
  end

  describe '#price' do
    let(:product) { Product.new(name: 'hoge', price: 150)}

    subject { product.price }

    it { is_expected.to eq 150 }

  end
end
