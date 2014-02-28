require 'spec_helper'
require 'cashregister'

describe Cashregister do
  describe "#initialize" do
    it "instantiates" do
      expect {
        Cashregister.new
      }.to_not raise_exception
    end
  end
end
