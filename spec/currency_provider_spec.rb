require "spec_helper"
require "currency"
require "currency_provider"

describe CurrencyProvider do
  it "provides currencies" do
    currencies = [{name: "US dollar", symbols: ["$", "USD"]}, {name: "Pound sterling", symbols: ["£", "GBP"]}]
    exchange_rate_provider = exchange_rate_provider_with(USD: 1.00, GBP: 0.61)

    provider = CurrencyProvider.new(currencies, exchange_rate_provider)

    expect(provider.currencies).to eq [Currency.new("US dollar", 1.00, "$", "USD"), Currency.new("Pound sterling", 0.61, "£", "GBP")]
  end

  def exchange_rate_provider_with(exchange_rates)
    double("exchange_rate_provider").tap do |provider|
      exchange_rates.each do |code, value|
        allow(provider).to receive(:exchange_rate_for).with(code.to_s).and_return(value)
      end
    end
  end
end
