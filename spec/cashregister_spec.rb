require 'spec_helper'
require 'cashregister'
require 'its'

describe CashRegister do
  subject(:cash_register) { CashRegister.new(coins) }
  let(:coins) { [25,10,5,1] }

  describe "#initialize" do
    context 'given [25,10,5,1]' do
      specify { expect { cash_register }.to_not raise_exception }
    end
    context 'when not given an Array' do
      let(:coins) { 'quarters and nickles' }
      specify { expect { cash_register }.to raise_exception }
    end
    context 'when not given an Array of Integers' do
      let(:coins) { ['quarters', 'nickles'] }
      specify { expect { cash_register }.to raise_exception }
    end
  end

  describe '.make_change' do
    its(:make_change, 0)   { should eq(nil) }
    its(:make_change, 5)   { should eq({25 => 0, 10 => 0, 5 => 1, 1 => 0}) }
    its(:make_change, 25)  { should eq({25 => 1, 10 => 0, 5 => 0, 1 => 0}) }
    its(:make_change, 123) { should eq({25 => 4, 10 => 2, 5 => 0, 1 => 3}) }
    context 'when calculating with crazy foreign coins' do
      let(:coins) { [10,7,1] }
      its(:make_change, 14) { should eq({10 => 0, 7 => 2, 1 => 0}) }
    end
    context 'when given a complex problem' do
      let(:coins) { [2,5,12,18,35,36] }
      its(:make_change, 67) { should eq({2=>1, 5=>0, 12=>1, 18=>1, 35=>1, 36=>0}) }
    end
    context 'when given a bad argument' do
      specify { expect { cash_register.make_change('about tree-fiddy') }.to raise_exception }
    end
  end
end
