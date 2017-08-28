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
end


