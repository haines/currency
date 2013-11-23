require "spec_helper"
require "currency"
require "money"
require "formatter"

describe Formatter do
  describe "#format" do
    let(:usd) { Currency.new("US dollar", 1.00, "$", "USD") }
    let(:gbp) { Currency.new("Pound sterling", 1.50, "£", "GBP") }

    it "adds feedback items for converted currencies" do
      results = [Money.new(2.50, usd), Money.new(3.75, gbp)]
      feedback = feedback_double

      thin_space = "\u2009"

      Formatter.new(feedback).format(results)

      expect(feedback).to have_received(:add_item).with(title: "$#{thin_space}2.50").once
      expect(feedback).to have_received(:add_item).with(title: "£#{thin_space}3.75").once
    end

    it "is chainable" do
      formatter = Formatter.new(feedback_double)

      expect(formatter.format([Money.new(2.50, usd)])).to eq formatter
    end
  end

  describe "#to_xml" do
    it "formats the feedback as XML" do
      feedback = feedback_double
      allow(feedback).to receive(:to_xml).and_return(:some_xml)

      expect(Formatter.new(feedback).to_xml).to be :some_xml
    end
  end

  def feedback_double
    double("feedback", add_item: nil)
  end
end
