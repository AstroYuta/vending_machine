require "spec_helper"
require "wallet"

RSpec.describe Wallet do
  let(:wallet) { Wallet.new(sum_of_money: sum_of_money) }
  describe '#sum_of_money' do
    #所持金額が実装されているかテストする   
    subject {wallet.sum_of_money}

    shared_examples 'sum_of_money' do |x|
      context "所持金額が#{x}円のとき" do
        let(:sum_of_money) { x }
        it { is_expected.to eq x }
      end
    end

    include_examples 'sum_of_money', 0
    include_examples 'sum_of_money', 500
    include_examples 'sum_of_money', 1234
    include_examples 'sum_of_money', 32450
    include_examples 'sum_of_money', 50000

    context '所持金額がマイナスのとき' do
      it {
        expect { Wallet.new(sum_of_money: -100) }.to raise_error(ArgumentError)
      }
    end

    context '財布に100円入れたとき' do
      a = 100
      let(:sum_of_money) { 100 + a }
      it { is_expected.to eq 200 }    
    end

    context '財布から100円抜いた時' do
      b = 100
      let(:sum_of_money) { 100 - b }
      it { is_expected.to eq 0 }
    end
  end

  describe '#merge' do
    subject { wallet.merge(Wallet.new(sum_of_money: 200)) }

    context '100円の入った財布と200円の入った財布を統合したとき' do
      let(:sum_of_money) { 100 }
      it { expect(subject.sum_of_money).to eq 300 }
    end

  end


end