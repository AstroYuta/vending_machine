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

  #以下は2商品がVendingMachineに入っている場合のテスト
  describe '#buy' do
    
    subject { machine.add_having_product(Product.new(name: "綾鷹", price: 150)).add_having_product(Product.new(name: "ヘルシア緑茶", price: 180)).insert_money(Money.new(amount: amount_of_inserted_money)).buy(name_of_buyed_product_at_first) }
    context '各々一つずつ買うとき' do
      context '200円投入して綾鷹を買うとき' do
        let(:amount_of_inserted_money) { 200 }
        let(:name_of_buyed_product_at_first) { "綾鷹" }

        it { expect(subject.calculate_inserted_money).to eq 50 }
        it { expect(subject.buyed_product.length).to eq 1 }      
        it { expect(subject.buyed_product[name_of_buyed_product_at_first]).to be_a Product }
        it { expect(subject.buyed_product[name_of_buyed_product_at_first].name).to eq "綾鷹" }
        it { expect(subject.buyed_product[name_of_buyed_product_at_first].price).to eq 150 }
      end

      context '200円投入してヘルシア緑茶を買うとき' do
        let(:amount_of_inserted_money) { 200 }
        let(:name_of_buyed_product_at_first) { "ヘルシア緑茶" }

        it { expect(subject.calculate_inserted_money).to eq 20 }
        it { expect(subject.buyed_product.length).to eq 1 }      
        it { expect(subject.buyed_product[name_of_buyed_product_at_first]).to be_a Product }
        it { expect(subject.buyed_product[name_of_buyed_product_at_first].name).to eq "ヘルシア緑茶" }
        it { expect(subject.buyed_product[name_of_buyed_product_at_first].price).to eq 180 }      
      end
    end

    context '同時に2商品購入するとき' do
      context '500円投入して綾鷹とヘルシア緑茶を買うとき' do
        let(:amount_of_inserted_money) { 500 }
        let(:name_of_buyed_product_at_first) { "綾鷹" }
        let(:name_of_buyed_product_at_second) { "ヘルシア緑茶" }

        it { expect(subject.buy(name_of_buyed_product_at_second).calculate_inserted_money).to eq 170 }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product.length).to eq 2 }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product[name_of_buyed_product_at_first]).to be_a Product }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product[name_of_buyed_product_at_first].name).to eq "綾鷹" }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product[name_of_buyed_product_at_first].price).to eq 150 }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product[name_of_buyed_product_at_second]).to be_a Product }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product[name_of_buyed_product_at_second].name).to eq "ヘルシア緑茶" }
        it { expect(subject.buy(name_of_buyed_product_at_second).buyed_product[name_of_buyed_product_at_second].price).to eq 180 }
      end
    end
  end
end


