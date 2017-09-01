require "spec_helper"

RSpec.describe Vendingmachine do
  let(:vendingmachine) { Vendingmachine.new }

  describe '#calculate_inserted_money' do

    subject { vendingmachine.calculate_inserted_money }

    context '初めVendingVendingvendingmachineには何もお金が投入されていないとき' do
      it { is_expected.to eq 0 }
    end
  end

  describe '#insert_money' do   

    subject { vendingmachine.insert_money(Money.new(amount: amount_of_inserted_money)) }

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
    
    subject { vendingmachine.insert_money(Money.new(amount: amount_of_inserted_money)).reset_inserted_money }

    context '100円投入してから取り消しをしたとき' do
      let(:amount_of_inserted_money) { 100 }
      it { expect(subject.calculate_inserted_money).to eq 0 }
    end
  end

  describe '#add_having_product' do
    
    subject { vendingmachine.add_having_product(Product.new(name: name_of_product, price: price_of_product)) }

    context '180円のヘルシア緑茶を追加したとき' do
      let(:name_of_product) { "ヘルシア緑茶" }
      let(:price_of_product) { Money.new(amount: 180) }

      it{ expect(subject.having_product.length).to eq 1 }
      it{ expect(subject.having_product[name_of_product]).to be_a Product }
      it{ expect(subject.having_product[name_of_product].name).to eq "ヘルシア緑茶" }
      it{ expect(subject.having_product[name_of_product].price.amount).to eq 180 }
    end
  end

  describe '#remove_having_product' do

    subject { vendingmachine.add_having_product(Product.new(name: name_of_added_product_at_first, price: price_of_added_product_at_first)).add_having_product(Product.new(name: name_of_added_product_at_second, price: price_of_added_product_at_second)).remove_having_product(name_of_removing_product) }
    let(:name_of_added_product_at_first) { "綾鷹" }
    let(:price_of_added_product_at_first) { Money.new(amount: 150) }
    let(:name_of_added_product_at_second) { "ヘルシア緑茶" }
    let(:price_of_added_product_at_second) { Money.new(amount: 180) }

    context '綾鷹をVendingVendingvendingmachineから取りのぞくとき' do
      let(:name_of_removing_product) { "綾鷹" }
      it { expect(subject.having_product.length).to eq 1 }
      it { expect(subject.having_product[name_of_removing_product]).to be_nil }
    end

    context 'ヘルシア緑茶をVendingVendingvendingmachineから取り除くとき' do
      let(:name_of_removing_product) { "ヘルシア緑茶" }
      it { expect(subject.having_product.length).to eq 1 }
      it { expect(subject.having_product[name_of_removing_product]).to be_nil }
    end
  end

  describe '#buy' do

    subject { vendingmachine.buy(name_of_buyed_product) }

    context '一つだけproductを入れ、それを購入するとき' do
      before {
        vendingmachine.add_having_product(Product.new(name: name_of_added_product, price: price_of_added_product)).insert_money(Money.new(amount: amount_of_inserted_money))
      }
      let(:name_of_added_product) { "綾鷹" }
      let(:price_of_added_product) { Money.new(amount: 150) }
      let(:name_of_buyed_product) { "綾鷹" }

      context '200円入れて購入するとき' do
        let(:amount_of_inserted_money) { 200 }

        it { expect(subject.calculate_inserted_money).to eq 50 }
        it { expect(subject.buyed_product.length).to eq 1 }      
        it { expect(subject.buyed_product[name_of_buyed_product]).to be_a Product }
        it { expect(subject.buyed_product[name_of_buyed_product].name).to eq "綾鷹" }
        it { expect(subject.buyed_product[name_of_buyed_product].price.amount).to eq 150 }
      end

      context '100円入れて購入するとき(お金が足りないとき)' do
        let(:amount_of_inserted_money) { 100 }

        it { expect {subject}.to raise_error ShortOfMoneyError }      
      end

      context 'having_productにないproductを買おうとしたとき' do
        let(:amount_of_inserted_money) { 200 }
        let(:name_of_buyed_product) { "コカコーラ" }

        it { expect {subject}.to raise_error ArgumentError }
      end
    end
    
    context '二つproductを入れ、それらを購入するとき' do
      before {
        vendingmachine.add_having_product(Product.new(name: name_of_added_product_at_first, price: price_of_added_product_at_first)).add_having_product(Product.new(name: name_of_added_product_at_second, price: price_of_added_product_at_second)).insert_money(Money.new(amount: amount_of_inserted_money))
      }
      let(:name_of_added_product_at_first) { "綾鷹" }
      let(:price_of_added_product_at_first) { Money.new(amount: 150) }
      let(:name_of_added_product_at_second) { "ヘルシア緑茶" }
      let(:price_of_added_product_at_second) { Money.new(amount:180) }

      context '各々一つずつ買うとき' do
        context '200円投入して綾鷹を買うとき' do
          let(:amount_of_inserted_money) { 200 }
          let(:name_of_buyed_product) { "綾鷹" }

          it { expect(subject.calculate_inserted_money).to eq 50 }
          it { expect(subject.buyed_product.length).to eq 1 }      
          it { expect(subject.buyed_product[name_of_buyed_product]).to be_a Product }
          it { expect(subject.buyed_product[name_of_buyed_product].name).to eq "綾鷹" }
          it { expect(subject.buyed_product[name_of_buyed_product].price.amount).to eq 150 }
        end

        context '200円投入してヘルシア緑茶を買うとき' do
          let(:amount_of_inserted_money) { 200 }
          let(:name_of_buyed_product) { "ヘルシア緑茶" }

          it { expect(subject.calculate_inserted_money).to eq 20 }
          it { expect(subject.buyed_product.length).to eq 1 }      
          it { expect(subject.buyed_product[name_of_buyed_product]).to be_a Product }
          it { expect(subject.buyed_product[name_of_buyed_product].name).to eq "ヘルシア緑茶" }
          it { expect(subject.buyed_product[name_of_buyed_product].price.amount).to eq 180 }      
        end
      end

      context '続けて2商品購入するとき' do
        context '500円投入して綾鷹を購入、続いてヘルシア緑茶を買うとき' do
          before {
            vendingmachine.buy(name_of_buyed_product_at_second)
          }
          let(:amount_of_inserted_money) { 500 }
          let(:name_of_buyed_product) { "綾鷹" }
          let(:name_of_buyed_product_at_second) { "ヘルシア緑茶" }

          it { expect(subject.calculate_inserted_money).to eq 170 }
          it { expect(subject.buyed_product.length).to eq 2 }
          it { expect(subject.buyed_product[name_of_buyed_product]).to be_a Product }
          it { expect(subject.buyed_product[name_of_buyed_product].name).to eq "綾鷹" }
          it { expect(subject.buyed_product[name_of_buyed_product].price.amount).to eq 150 }
          it { expect(subject.buyed_product[name_of_buyed_product_at_second]).to be_a Product }
          it { expect(subject.buyed_product[name_of_buyed_product_at_second].name).to eq "ヘルシア緑茶" }
          it { expect(subject.buyed_product[name_of_buyed_product_at_second].price.amount).to eq 180 }
        end
      end
    end
  end
end


