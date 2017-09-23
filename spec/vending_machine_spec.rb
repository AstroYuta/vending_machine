require "spec_helper"

RSpec.describe VendingMachine do
  let(:vendingmachine) { VendingMachine.new }

  describe '#calculate_inserted_money' do

    subject { vendingmachine.calculate_inserted_money }

    context '初めVendingMachineには何もお金が投入されていないとき' do
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
      it { expect{ subject }.to raise_error ArgumentError }
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

    context '150円の綾鷹を追加するとき' do
      subject {
        vendingmachine.add_having_product(product: product, number_of_added_product: number_of_added_product)
      }
      let(:product) { Product.new(name: name_of_added_product, price: price_of_added_product) }
      let(:name_of_added_product) { "綾鷹" }
      let(:price_of_added_product) { Money.new(amount: 150) }

      context '1本追加したとき' do
        let(:number_of_added_product) { 1 }

        it {expect(subject.having_product.length).to eq 1 }
        it {expect(subject.having_product[name_of_added_product]).to be_a Product }
        it {expect(subject.having_product[name_of_added_product].name).to eq "綾鷹" }
        it {expect(subject.having_product[name_of_added_product].price.amount).to eq 150 }
        it {expect(subject.stock[product]).to eq 1 }
      end

      context '-5本追加したとき' do
        let(:number_of_added_product) { -5 }

        it { expect{ subject }.to raise_error ArgumentError }
      end
    end
    
    context '180円のヘルシア緑茶と150円の綾鷹を1本ずつ追加したとき' do
      before {
        vendingmachine.add_having_product(
          { product: product1, number_of_added_product: number_of_added_product1 },
          { product: product2, number_of_added_product: number_of_added_product2 }
        )
      }
      let(:product1) { Product.new(name: name_of_added_product1, price: price_of_added_product1) }
      let(:name_of_added_product1) { "ヘルシア緑茶" }
      let(:price_of_added_product1) { Money.new(amount: 180) }
      let(:number_of_added_product1) { 1 }

      let(:product2) { Product.new(name: name_of_added_product2, price: price_of_added_product2) }
      let(:name_of_added_product2) { "綾鷹" }
      let(:price_of_added_product2) { Money.new(amount: 150) }
      let(:number_of_added_product2) { 1 }

      it{ expect(vendingmachine.having_product.length).to eq 2 }

      it{ expect(vendingmachine.having_product[name_of_added_product1]).to be_a Product }
      it{ expect(vendingmachine.having_product[name_of_added_product1].name).to eq "ヘルシア緑茶" }
      it{ expect(vendingmachine.having_product[name_of_added_product1].price.amount).to eq 180 }
      it{ expect(vendingmachine.stock[product1]).to eq 1 }

      it{ expect(vendingmachine.having_product[name_of_added_product2]).to be_a Product }
      it{ expect(vendingmachine.having_product[name_of_added_product2].name).to eq "綾鷹" }
      it{ expect(vendingmachine.having_product[name_of_added_product2].price.amount).to eq 150 }
      it{ expect(vendingmachine.stock[product2]).to eq 1 }
    end
  end

  describe '#remove_having_product' do

    before {
      vendingmachine.add_having_product(
        { product: Product.new(name: name_of_added_product1, price: price_of_added_product1), number_of_added_product: number_of_added_product1 },
        { product: Product.new(name: name_of_added_product2, price: price_of_added_product2), number_of_added_product: number_of_added_product2 }
      )
    }
    let(:name_of_added_product1) { "綾鷹" }
    let(:price_of_added_product1) { Money.new(amount: 150) }
    let(:name_of_added_product2) { "ヘルシア緑茶" }
    let(:price_of_added_product2) { Money.new(amount: 180) }
    let(:number_of_added_product1) { 5 }
    let(:number_of_added_product2) { 5 }

    context '綾鷹だけを取りのぞくとき' do
      subject {
        vendingmachine.remove_having_product(product: removing_product, number_of_removing_product: number_of_removing_product)
      }
      let(:removing_product) { Product.new(name: "綾鷹", price: Money.new(amount: 150)) }

      context '綾鷹を1本取りのぞくとき' do
        let(:number_of_removing_product) { 1 }
        it {
          expect(subject.stock[removing_product]).to eq 4 
        }
      end

      context '綾鷹を100本取りのぞくとき' do
        let(:number_of_removing_product) { 100 }
        it { expect {subject}.to raise_error ShortOfStockError }
      end

      context '綾鷹を-5本取りのぞくとき' do
        let(:number_of_removing_product) { -5 }
        it { expect {subject}.to raise_error ArgumentError }
      end

    end

    context '綾鷹、ヘルシア緑茶共に5本入っている状態から、綾鷹4本とヘルシア緑茶1本を取りのぞくとき' do
      before {
        vendingmachine.remove_having_product(
          { product: removing_product1, number_of_removing_product: number_of_removing_product1},
          { product: removing_product2, number_of_removing_product: number_of_removing_product2})
      }
      let(:removing_product1) { Product.new(name: "綾鷹", price: Money.new(amount: 150)) }
      let(:number_of_removing_product1) { 4 }
      let(:removing_product2) { Product.new(name: "ヘルシア緑茶", price: Money.new(amount: 180)) }
      let(:number_of_removing_product2) { 1 }
      
      it { expect(vendingmachine.stock[removing_product1]).to eq 1 }
      it { expect(vendingmachine.stock[removing_product2]).to eq 4 }
    end
  end

  describe '#stock' do

    subject { vendingmachine.stock[having_product] }

    context '綾鷹が1つ入っている時' do
      before {
        vendingmachine.add_having_product(product: Product.new(name: "綾鷹", price: Money.new(amount: 150)), number_of_added_product: 1)
      }

      let(:having_product) { Product.new(name: "綾鷹", price: Money.new(amount:150)) }

      it { is_expected.to eq 1 }
    end
  end

  describe '#buy' do

    subject { vendingmachine.buy(buyed_product) }

    context '一つだけproductを入れ、それを購入するとき' do
      before {
        vendingmachine.add_having_product(product: Product.new(name: name_of_added_product, price: price_of_added_product), number_of_added_product: number_of_added_product ).insert_money(Money.new(amount: amount_of_inserted_money))
      }
      let(:name_of_added_product) { "綾鷹" }
      let(:price_of_added_product) { Money.new(amount: 150) }
      let(:number_of_added_product) { 1 }

      let(:buyed_product) { Product.new(name: name_of_buyed_product, price: price_of_buyed_product) }
      let(:name_of_buyed_product) { "綾鷹" }
      let(:price_of_buyed_product) { Money.new(amount: 150) }

      context '200円入れて購入するとき' do
        let(:amount_of_inserted_money) { 200 }

        it { expect(subject.calculate_inserted_money).to eq 50 }

        it { expect(subject.buyed_product.length).to eq 1 }      
        it { expect(subject.buyed_product[buyed_product.name]).to be_a Product }
        it { expect(subject.buyed_product[buyed_product.name].name).to eq "綾鷹" }
        it { expect(subject.buyed_product[buyed_product.name].price.amount).to eq 150 }

        it { expect(subject.stock[buyed_product]).to eq 0 }
      end

      context '100円入れて購入するとき(お金が足りないとき)' do
        let(:amount_of_inserted_money) { 100 }

        it { expect{ subject }.to raise_error ShortOfMoneyError }
      end

      context 'having_productにないproductを買おうとしたとき' do
        let(:amount_of_inserted_money) { 200 }
        let(:name_of_buyed_product) { "コカコーラ" }

        it { expect{ subject }.to raise_error ArgumentError }
      end

      context '在庫のないproductを買おうとしたとき' do
        let(:number_of_added_product) { 0 }
        let(:amount_of_inserted_money) { 200 }

        it { expect{ subject }.to raise_error ShortOfStockError }
      end
    end
    
    context '二つproductを入れ、それらを購入するとき' do
      before {
        vendingmachine.add_having_product(
          { product: Product.new(name: name_of_added_product_at_first, price: price_of_added_product_at_first), number_of_added_product: number_of_product },
          { product: Product.new(name: name_of_added_product_at_second, price: price_of_added_product_at_second), number_of_added_product: number_of_product }).insert_money(Money.new(amount: amount_of_inserted_money))
      }
      let(:name_of_added_product_at_first) { "綾鷹" }
      let(:price_of_added_product_at_first) { Money.new(amount: 150) }
      let(:name_of_added_product_at_second) { "ヘルシア緑茶" }
      let(:price_of_added_product_at_second) { Money.new(amount:180) }
      let(:number_of_product) { 1 }

      context '各々一つずつ買うとき' do
        context '200円投入して綾鷹を買うとき' do
          let(:amount_of_inserted_money) { 200 }
          let(:buyed_product) { Product.new(name: name_of_buyed_product, price: price_of_buyed_product) }
          let(:name_of_buyed_product) { "綾鷹" }
          let(:price_of_buyed_product) { Money.new(amount: 150) }

          it { expect(subject.calculate_inserted_money).to eq 50 }

          it { expect(subject.buyed_product.length).to eq 1 }
          it { expect(subject.buyed_product[buyed_product.name]).to be_a Product }
          it { expect(subject.buyed_product[buyed_product.name].name).to eq "綾鷹" }
          it { expect(subject.buyed_product[buyed_product.name].price.amount).to eq 150 }

          it { expect(subject.stock[buyed_product]).to eq 0 }
        end

        context '200円投入してヘルシア緑茶を買うとき' do
          let(:amount_of_inserted_money) { 200 }
          let(:buyed_product) { Product.new(name: name_of_buyed_product, price: price_of_buyed_product) }
          let(:name_of_buyed_product) { "ヘルシア緑茶" }
          let(:price_of_buyed_product) { Money.new(amount: 180) }

          it { expect(subject.calculate_inserted_money).to eq 20 }

          it { expect(subject.buyed_product.length).to eq 1 }      
          it { expect(subject.buyed_product[buyed_product.name]).to be_a Product }
          it { expect(subject.buyed_product[buyed_product.name].name).to eq "ヘルシア緑茶" }
          it { expect(subject.buyed_product[buyed_product.name].price.amount).to eq 180 }

          it { expect(subject.stock[buyed_product]).to eq 0 }
        end
      end

      context '続けて2商品購入するとき' do
        context '500円投入して綾鷹を購入、続いてヘルシア緑茶を買うとき' do
          before {
            vendingmachine.buy(buyed_product_at_second)
          }
          let(:amount_of_inserted_money) { 500 }
          let(:buyed_product) { Product.new(name: name_of_buyed_product, price: price_of_buyed_product) }
          let(:name_of_buyed_product) { "綾鷹" }
          let(:price_of_buyed_product) { Money.new(amount: 150) }

          let(:buyed_product_at_second) { Product.new(name: name_of_buyed_product_at_second, price: price_of_buyed_product_at_second)}
          let(:name_of_buyed_product_at_second) { "ヘルシア緑茶" }
          let(:price_of_buyed_product_at_second) { Money.new(amount: 180) }

          it { expect(subject.calculate_inserted_money).to eq 170 }

          it { expect(subject.buyed_product.length).to eq 2 }
          it { expect(subject.buyed_product[buyed_product.name]).to be_a Product }
          it { expect(subject.buyed_product[buyed_product.name].name).to eq "綾鷹" }
          it { expect(subject.buyed_product[buyed_product.name].price.amount).to eq 150 }
          it { expect(subject.stock[buyed_product]).to eq 0 }

          it { expect(subject.buyed_product[buyed_product_at_second.name]).to be_a Product }
          it { expect(subject.buyed_product[buyed_product_at_second.name].name).to eq "ヘルシア緑茶" }
          it { expect(subject.buyed_product[buyed_product_at_second.name].price.amount).to eq 180 }
          it { expect(subject.stock[buyed_product_at_second]).to eq 0 }
        end
      end
    end
  end
end


