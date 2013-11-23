require "json"
require "open-uri"
require "active_support/core_ext/hash/keys"
require "environment/load"

class ExchangeRateUpdater
  URI = "http://openexchangerates.org/api/latest.json?app_id=#{ENV["OPEN_EXCHANGE_RATES_APP_ID"]}"

  def download
    response = JSON.load(open(URI))
    {
      exchange_rates: response.fetch("rates").symbolize_keys,
      updated_at: Time.at(response.fetch("timestamp"))
    }
  end
end
