require "spec_helper"
require "currency"
require "money"
require "converter"

describe Converter do
  describe "#convert" do
    let(:usd) { Currency.new("US dollar", 1.00, "$") }
    let(:eur) { Currency.new("Euro", 0.75, "€") }
    let(:gbp) { Currency.new("Pound sterling", 0.61, "£") }

    it "converts input into other currencies" do
      parser = double("parser")
      allow(parser).to receive(:parse).with("$10").and_return(Money.new(10, usd))
      converter = Converter.new([usd, eur, gbp], parser)

      expect(converter.convert("$10")).to eq [Money.new(7.50, eur), Money.new(6.10, gbp)]
    end

    it "does not convert junk input" do
      parser = double("parser", parse: nil)
      converter = Converter.new([usd, eur, gbp], parser)

      expect(converter.convert("$2a")).to eq []
    end
  end
end
