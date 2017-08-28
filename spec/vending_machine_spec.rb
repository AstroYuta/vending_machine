require "spec_helper"

RSpec.describe VendingMachine do

  let(:machine) { Machine.new(product: Product.new(name: name_of_product, price: price_of_product)) }

  describe '#calculate_inserted_money' do
    let(:name_of_product) { "Ayataka" }
    let(:price_of_product) { 150 }

    subject { machine.calculate_inserted_money }

    context '初めVendingMachineには何もお金が投入されていないとき' do
      it { is_expected.to eq 0 }
    end
  end

  describe '#insert_money' do
    let(:name_of_product) { "Ayataka" }
    let(:price_of_product) { 150 }    

    subject { machine.insert_money(Money.new(amount: amount_of_inserted_money)) }

    context '初めて100円足したとき' do
      let(:amount_of_inserted_money) { 100 }
      it { expect(subject.calculate_inserted_money).to eq 100 }
    end
  end
end


