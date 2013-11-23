require "spec_helper"
require "currency"

describe Currency do
  describe "#name" do
    it "describes the currency" do
      expect(Currency.new("US dollar", 1.00).name).to eq "US dollar"
    end
  end

  describe "#exchange_rate" do
    it "measures the value of the currency relative to some baseline" do
      expect(Currency.new("Pound sterling", 0.61).exchange_rate).to eq 0.61
    end
  end

  describe "#symbols" do
    it "lists the symbols that represent the currency" do
      expect(Currency.new("US dollar", 1.00, "$", "US$", "USD").symbols).to eq ["$", "US$", "USD"]
    end
  end

  describe "#symbol" do
    it "returns the first symbol used to represent the currency" do
      expect(Currency.new("US dollar", 1.00, "$", "US$", "USD").symbol).to eq "$"
    end
  end
end
