require "spec_helper"
require "currency"
require "money"

describe Money do
  let(:usd) { Currency.new("US dollar", 1.00, "$") }
  let(:gbp) { Currency.new("Pound sterling", 0.61, "£") }

  describe "#convert_to" do
    it "converts between currencies" do
      expect(Money.new(2.00, usd).convert_to(gbp)).to eq Money.new(1.22, gbp)
    end
  end

  describe "#==" do
    it "is true for equal amounts of the same currency" do
      expect(Money.new(1.00, usd) == Money.new(1.00, usd)).to be_truthy
    end

    it "is false for different amounts of the same currency" do
      expect(Money.new(1.00, usd) == Money.new(2.00, usd)).to be_falsey
    end

    it "is false for amounts in different currencies" do
      expect(Money.new(1.00, usd) == Money.new(1.00, gbp)).to be_falsey
    end
  end

  describe "#to_s" do
    it "formats the amount and currency" do
      thin_space = "\u2009"
      expect(Money.new(1.50, usd).to_s).to eq "$#{thin_space}1.50"
    end
  end
end
