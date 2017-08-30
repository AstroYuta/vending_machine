require "spec_helper"

RSpec.describe VendingMachine do
  let(:machine) { Machine.new }

  describe '#calculate_inserted_money' do

    subject { machine.calculate_inserted_money }

    context '初めVendingMachineには何もお金が投入されていないとき' do
      it { is_expected.to eq 0 }
    end
  end

  describe '#insert_money' do   

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

  describe '#reset_inserted_money' do
    
    subject { machine.insert_money(Money.new(amount: amount_of_inserted_money)).reset_inserted_money }

    context '100円投入してから取り消しをしたとき' do
      let(:amount_of_inserted_money) { 100 }
      it { expect(subject.calculate_inserted_money).to eq 0 }
    end
  end

  describe '#add_having_product' do
    
    subject { machine.add_having_product(Product.new(name: name_of_product, price: price_of_product)) }

    context '180円のヘルシア緑茶を追加したとき' do
      let(:name_of_product) { "ヘルシア緑茶" }
      let(:price_of_product) { 180 }

      it{ expect(subject.having_product.length).to eq 1 }
      it{ expect(subject.having_product[name_of_product]).to be_a Product }
      it{ expect(subject.having_product[name_of_product].name).to eq "ヘルシア緑茶" }
      it{ expect(subject.having_product[name_of_product].price).to eq 180 }
    end
  end

  describe '#buy' do

    subject { machine.add_having_product(Product.new(name: name_of_product, price: price_of_product)).insert_money(Money.new(amount: amount_of_inserted_money)).buy(name_of_product) }
    let(:name_of_product) { "綾鷹" }
    let(:price_of_product) { 150 }

    context '200円入れて購入するとき' do
      let(:amount_of_inserted_money) { 200 }
      it { expect(subject.calculate_inserted_money).to eq 50 }
      it { expect(subject.buyed_product.length).to eq 1 }      
      it { expect(subject.buyed_product[name_of_product]).to be_a Product }
      it { expect(subject.buyed_product[name_of_product].name).to eq "綾鷹" }
      it { expect(subject.buyed_product[name_of_product].price).to eq 150 }
    end

    context '100円入れて購入するとき(お金が足りないとき)' do
      let(:amount_of_inserted_money) { 100 }
      it { expect {subject}.to raise_error ArgumentError }      
    end
  end
end


