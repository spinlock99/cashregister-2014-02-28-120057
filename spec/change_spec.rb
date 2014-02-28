require 'spec_helper'
require 'change'
require 'its'

describe Change do
  subject(:change) { Change.new coins }
  let(:coins) { [10,5,1] }

  describe '#new' do
    context 'given an [10, 5, 1]' do
      it { expect { change }.to_not raise_error }
      it { should eq({10 => 0, 5 => 0, 1 => 0}) }
    end
    context 'given no input' do
      it { expect { Change.new }.to raise_error }
    end
    context 'when not given an array' do
      let(:coins) { 'nickles and quarters' }
      it { expect { change }.to raise_error }
    end
    context 'when not given an Array of Integers' do
      let(:coins) { ['nickles', 'quarters'] }
      specify { expect { change }.to raise_error /expected array of integers/i }
    end
  end

  describe '.add' do
    subject(:add) { change.add(coin) }
    context 'given a known coin' do
      let(:coin) { 5 }
      it 'does not modify the object' do
        change.add(coin)
        change.should eq({10 => 0, 5 => 0, 1 => 0})
      end
      it 'returns a new object with the coint of the given coin incremented.' do
        change.add(coin).should eq({10 => 0, 5 => 1, 1 => 0})
      end
    end
    context 'given an unknown coin' do
      let(:coin) { 25 }
      specify { expect { add }.to raise_error /unkown coin/i }
    end
  end

  describe '.count_coins' do
    its(:count_coins) { should eq(0) }
    it 'counts the coins in a pile of change' do
      change.add(5).add(5).count_coins.should eq(2)
    end
  end

  describe '.value' do
    its(:value) { should eq(0) }
    it 'returns the monetary value of the Change object' do
      change.add(5).add(5).value.should eq(10)
    end
  end
end
