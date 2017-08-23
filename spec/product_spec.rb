require "spec_helper"

RSpec.describe Product do
  let(:product) { Product.new(name: name, price: price) }
  let(:name)    { 'default name' }
  let(:price)   { 0 }

  describe '#name' do
    subject { product.name }

    context 'nameがhogeの場合' do
      let(:name) { 'hoge' }

      it { is_expected.to eq name }
    end

    context 'nameがコーラの場合' do
      let(:name) { 'コーラ' }
      it { is_expected.to eq name }
    end
  end

  describe '#price' do
    let(:price) { 150 }
    
    subject { product.price }

    it { is_expected.to eq 150 }
  end
end
