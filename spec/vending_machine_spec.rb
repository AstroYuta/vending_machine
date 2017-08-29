require "spec_helper"

RSpec.describe VendingMachine do

  let(:machine) { Machine.new(product: Product.new(name: name_of_product, price: price_of_product)) }
  let(:name_of_product) { "綾鷹" }
  let(:price_of_product) { 150 }

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

  describe '#product.name' do
    
    subject { machine.product[:name_of_product].name }

    context '綾鷹が売られているとき' do
      let(:name_of_product) { "綾鷹" } #あえてもう一度定義します
      it { is_expected.to eq "綾鷹" }
    end

    context 'Irohasが売られているとき' do
      let(:name_of_product) { "Irohas" }
      it { is_expected.to eq "Irohas" }
    end
  end

  describe '#product.price' do

    subject { machine.product[:name_of_product].price }

    context '150円で売られているとき' do
      let(:price_of_product) { 150 } #ここでもあえてもう一度定義しています
      it { is_expected.to eq 150 }
    end

    context '180円で売られているとき' do
      let(:price_of_product) { 180 }
      it { is_expected.to eq 180 }
    end
  end

  describe '#add_product' do
    
    subject { machine.add_product(Product.new(name: name_of_product, price: price_of_product)) }

    context '180円のヘルシア緑茶を追加したとき' do
      let(:name_of_product) { "ヘルシア緑茶" }
      let(:price_of_product) { 180 }

      it{ expect(subject.product.length).to eq 2 }
      it{ expect(subject.product[:name_of_product]).to be_a Product }
      it{ expect(subject.product[:name_of_product].name).to eq "ヘルシア緑茶" }
      it{ expect(subject.product[:name_of_product].price).to eq 180 }
    end
  end


  describe '#buy' do

    subject { machine.insert_money(Money.new(amount: amount_of_inserted_money)).buy(:name_of_product) }
    let(:name_of_product) { "綾鷹" }

    context '200円入れて購入するとき' do
      let(:amount_of_inserted_money) { 200 }
      it { expect(subject.calculate_inserted_money).to eq 50 }
    end

    context '100円入れて購入するとき(お金が足りないとき)' do
      let(:amount_of_inserted_money) { 100 }
      it { expect {subject}.to raise_error ArgumentError }      
    end
  end
end


