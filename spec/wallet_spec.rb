require "spec_helper"
require "wallet"

RSpec.describe Wallet do
  let(:wallet) { Wallet.new(sum_of_money: sum_of_money) }
  describe '#sum_of_money' do
    
    subject {wallet.sum_of_money}

    shared_examples 'sum_of_money' do |x|
      context "所持金額が#{x}円のとき" do
        let(:sum_of_money) { x }
        it { is_expected.to eq x }
      end
    end

    include_examples 'sum_of_money', 1000
    include_examples 'sum_of_money', 500
    include_examples 'sum_of_money', 1234
    include_examples 'sum_of_money', 32450
    include_examples 'sum_of_money', 50000


  end


end