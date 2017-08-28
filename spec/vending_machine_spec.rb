require "spec_helper"

RSpec.describe VendingMachine do

  let(:machine) { Machine.new(product: Product.new(name: name_of_product, price: price_of_product), money: Money.new(amount: amount_of_inserted_money)) }

  describe '#calculate_inserted_money' do
    let(:name_of_product) { "Ayataka" }
    let(:price_of_product) { 150 }

    context '200円投入されたとき' do
      let(:amount_of_inserted_money) { 200 }

      subject { machine.calculate_inserted_money }

      it { is_expected.to eq 200 }
    end
  end
end


