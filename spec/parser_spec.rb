require "spec_helper"
require "currency"
require "money"
require "parser"

describe Parser do
  describe "#parse" do
    def self.it_parses(description, expected_amount, expected_currency, *inputs)
      it("parses #{description}") do
        inputs.each do |input|
          expect(parser.parse(input)).to eq Money.new(expected_amount, expected_currency)
        end
      end
    end

    usd = Currency.new("US dollar", 1.00, "USD", "$", "US$")

    let(:parser) { Parser.new([usd]) }

    it_parses "integer money with a space",
              1.00, usd,
              "USD 1", "$ 1", "US$ 1"

    it_parses "floating-point money with a space",
              1.50, usd,
              "USD 1.50", "$ 1.50", "US$ 1.50"

    it_parses "integer money without a space",
              2.00, usd,
              "USD2", "$2", "US$2"

    it_parses "floating-point money without a space",
              2.50, usd,
              "USD2.50", "$2.50", "US$2.50"

    it_parses "floating-point money with a trailing decimal point",
              3.00, usd,
              "USD3.", "$3.", "US$3."

    it_parses "floating-point money with a leading decimal point",
              0.40, usd,
              "USD.40", "$.40", "US$.40"

    it "does not parse junk input" do
      expect(parser.parse("$foo")).to be_nil
    end
  end
end
