require "spec_helper"

RSpec.describe VendingMachine do

  let(:machine) { Machine.new(product: Product.new(name: name_of_product, price: price_of_product)) }
  let(:name_of_product) { "Ayataka" }
  let(:price_of_product) { 150 }

  describe '#calculate_inserted_money' do

    subject { machine.calculate_inserted_money }

    context '初めVendingMachineには何もお金が投入されていないとき' do
      it { is_expected.to eq 0 }
    end
  end

  describe '#insert_money' do
    let(:name_of_product) { "Ayataka" }
    let(:price_of_product) { 150 }    

    subject { machine.insert_money(Money.new(amount: amount_of_inserted_money)) }

    context '100円投入したとき' do
      let(:amount_of_inserted_money) { 100 }
      it { expect(subject.calculate_inserted_money).to eq 100 }
    end

    context '-100円投入したとき' do
      let(:amount_of_inserted_money) { -100 }
      it { expect {subject}.to raise_error ArgumentError }
    end

    context '100円投入してから、50円投入したとき' do
      let(:amount_of_inserted_money) { 100 }
      it { expect(subject.insert_money(Money.new(amount: 50)).calculate_inserted_money).to eq 150 }
    end
  end

  describe '#product.name' do
    
    subject { machine.product.name }

    context 'Ayatakaが売られているとき' do
      let(:name_of_product) { "Ayataka" } #あえてもう一度定義します
      it { is_expected.to eq "Ayataka" }
    end

    context 'Irohasが売られているとき' do
      let(:name_of_product) { "Irohas" }
      it { is_expected.to eq "Irohas" }
    end
  end


end


