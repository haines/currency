require "currency"
require "preferred_currencies"
require "exchange_rate_provider"

class CurrencyProvider
  def initialize(preferred_currencies = PreferredCurrencies.load, exchange_rate_provider = ExchangeRateProvider.new)
    @preferred_currencies = preferred_currencies
    @exchange_rate_provider = exchange_rate_provider
  end

  def currencies
    preferred_currencies.map {|currency| build(currency) }
  end

  def self.currencies
    new.currencies
  end

  private

  attr_reader :preferred_currencies, :exchange_rate_provider

  def build(name:, symbols:)
    Currency.new(name, exchange_rate_for(symbols.last), *symbols)
  end

  def exchange_rate_for(currency)
    exchange_rate_provider.exchange_rate_for(currency)
  end
end
