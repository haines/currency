require "exchange_rate_cache"
require "exchange_rate_updater"

class ExchangeRateProvider
  def initialize(cache = ExchangeRateCache.load, updater = ExchangeRateUpdater.new)
    @cache = cache
    @updater = updater
  end

  def exchange_rate_for(currency)
    update_cache if cache.stale?
    cache.exchange_rate_for(currency)
  end

  private

  attr_reader :cache, :updater

  def update_cache
    cache.update updater.download
  end
end
