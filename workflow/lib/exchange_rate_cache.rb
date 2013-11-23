require "yaml"
require "active_support/core_ext/numeric/time"

class ExchangeRateCache
  PATH = File.expand_path("../exchange_rate_cache.yml", __dir__)

  attr_reader :exchange_rates, :updated_at

  def initialize(**values)
    set values
  end

  def stale?
    updated_at <= 1.hour.ago
  end

  def exchange_rate_for(currency)
    exchange_rates.fetch(currency.to_sym)
  end

  def self.load
    return empty unless File.exists?(PATH)
    new(YAML.load_file(PATH))
  end

  def update(**values)
    set values
    save
  end

  def save
    File.write PATH, to_yaml
  end

  def to_yaml
    to_h.to_yaml
  end

  def to_h
    {exchange_rates: exchange_rates, updated_at: updated_at}
  end

  private

  def set(exchange_rates:, updated_at:)
    @exchange_rates = exchange_rates
    @updated_at = updated_at
  end

  def self.empty
    new(exchange_rates: {}, updated_at: Time.new(0))
  end
end
