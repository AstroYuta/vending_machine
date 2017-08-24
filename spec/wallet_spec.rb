require "spec_helper"
require "wallet"

RSpec.describe Wallet do
  let(:wallet) { Wallet.new(n_of_1yen: n_of_1yen, n_of_10yen: n_of_10yen,
    n_of_50yen: n_of_50yen, n_of_100yen: n_of_100yen, n_of_500yen: n_of_500yen) }
  #ここから枚数がちゃんと実装されているか愚直に書いてみる
  #マイナスになるテストは、硬貨だけがマイナスになる場合にとどめ、sum_of_moneyがマイナスになるときは下でテストする
  describe '#n_of_1yen' do
    subject { wallet.n_of_1yen }
    let(:n_of_10yen) { 0 }
    let(:n_of_50yen) { 0 }
    let(:n_of_100yen) { 0 }
    let(:n_of_500yen) { 4 }

    context '1円玉を1枚持っている時' do
      let(:n_of_1yen) { 1 }

      it {is_expected.to eq 1}
    end

    context 'sum_of_moneyはプラスだが、抜けない数の1円玉を抜いた時' do
      a = 2
      let(:n_of_1yen) { 1 - a }

      it {
        expect { wallet }.to raise_error(ArgumentError)
      }   
    end

  end

  describe '#n_of_10yen' do
    subject { wallet.n_of_10yen }
    let(:n_of_1yen) { 0 }
    let(:n_of_50yen) { 0 }
    let(:n_of_100yen) { 0 }
    let(:n_of_500yen) { 0 }

    context '10円玉を1枚持っている時' do
      let(:n_of_10yen) { 1 }

      it {is_expected.to eq 1}
    end

    context 'sum_of_moneyはプラスだが抜けない数の10円玉を抜いた時' do
      a = 2
      let(:n_of_10yen) { 1 - a }

      it {
        expect { wallet }.to raise_error(ArgumentError)
      }   
    end
  end

  describe '#n_of_50yen' do
    subject { wallet.n_of_50yen }
    let(:n_of_1yen) { 0 }
    let(:n_of_10yen) { 0 }
    let(:n_of_100yen) { 0 }
    let(:n_of_500yen) { 0 }

    context '50円玉を1枚持っている時' do
      let(:n_of_50yen) { 1 }

      it { is_expected.to eq 1 }
    end

    context 'sum_of_moneyはプラスだが抜けない数の50円玉を抜いた時' do
      a = 2
      let(:n_of_50yen) { 1 - a }

      it {
        expect { wallet }.to raise_error(ArgumentError)
      }   
    end
  end  

  describe '#n_of_100yen' do
    let(:n_of_1yen) { 0 }
    let(:n_of_10yen) { 0 }
    let(:n_of_50yen) { 0 }
    let(:n_of_500yen) { 0 }    
    subject { wallet.n_of_100yen }

    context '100円玉を1枚持っている時' do
      let(:n_of_100yen) { 1 }

      it {is_expected.to eq 1}
    end

    context 'sum_of_moneyはプラスだが抜けない数の100円玉を抜いた時' do
      a = 2
      let(:n_of_100yen) { 1 - a }

      it {
        expect { wallet }.to raise_error(ArgumentError)
      }   
    end

  end  

  describe '#n_of_500yen' do
    subject { wallet.n_of_500yen }
    let(:n_of_1yen) { 0 }
    let(:n_of_10yen) { 0 }
    let(:n_of_50yen) { 0 }
    let(:n_of_100yen) { 0 }

    context '500円玉を1枚持っている時' do
      let(:n_of_500yen) { 1 }

      it {is_expected.to eq 1}
    end

    context 'sum_of_moneyはプラスだが抜けない数の500円玉を抜いた時' do
      a = 2
      let(:n_of_500yen) { 1 - a }

      it {
        expect { wallet }.to raise_error(ArgumentError)
      }   
    end

  end #おしまい！

  describe '#sum_of_money' do
    #所持金額(sum_of_money)が実装されているかテストする   
    subject {wallet.sum_of_money}

    context '1円玉を1枚, 10円玉を2枚, 50円玉を1枚, 100円玉を4枚, 500円玉を1枚もっているとき' do
      let(:n_of_1yen) { 1 }
      let(:n_of_10yen) { 2 }
      let(:n_of_50yen) { 1 }
      let(:n_of_100yen) { 4 }
      let(:n_of_500yen) { 1 }

      it {is_expected.to eq 971}
    end

    context '所持金額がマイナスのとき' do
      it {
        expect { Wallet.new(n_of_1yen: -1, n_of_10yen: 0, n_of_50yen:0,
          n_of_100yen: 0, n_of_500yen: 0) }.to raise_error(ArgumentError)
      }
    end

    context '財布に100円玉が2枚あり、そこに100円玉を1枚入れたとき' do
      let(:n_of_1yen) { 0 }
      let(:n_of_10yen) { 0 }
      let(:n_of_50yen) { 0 }
      let(:n_of_500yen) { 0 }
      
      a = 1
      let(:n_of_100yen) { 2 + a }
      it { is_expected.to eq 300 }    
    end

    context '財布に50円玉が5枚あり、そこから50円玉を3枚抜いた時' do
      let(:n_of_1yen) { 0 }
      let(:n_of_10yen) { 0 }
      let(:n_of_100yen) { 0 }
      let(:n_of_500yen) { 0 }

      b = 3
      let(:n_of_50yen) { 5 - b }
      it { is_expected.to eq 100 }
    end
  end

  # describe '#merge' do
  #   subject { wallet.merge(Wallet.new(sum_of_money: 200, n_of_1yen: 0, n_of_10yen: 0, n_of_50yen: 0, n_of_100yen: 2, n_of_500yen: 0)) }
  #   let(:n_of_1yen) { 0 }
  #   let(:n_of_10yen) { 0 }
  #   let(:n_of_50yen) { 0 }
  #   let(:n_of_100yen) { 5 }
  #   let(:n_of_500yen) { 1 }    

  #   context '100円の入った財布と200円の入った財布を統合したとき' do
  #     let(:sum_of_money) { 100 }
  #     it { expect(subject.sum_of_money).to eq 300 }
  #   end
end