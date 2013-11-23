require "spec_helper"
require "fakefs_helper"
require "exchange_rate_cache"

describe ExchangeRateCache do
  fake_directory_containing ExchangeRateCache::PATH

  it "saves exchange rates" do
    exchange_rates = {USD: 1.00, GBP: 0.61}
    updated_at = Time.now

    ExchangeRateCache.new(exchange_rates: exchange_rates, updated_at: updated_at).save

    cache = ExchangeRateCache.load

    expect(cache.exchange_rates).to eq exchange_rates
    expect(cache.updated_at).to eq updated_at
  end

  describe ".load" do
    context "when a cache does not exist" do
      it "retrieves an empty hash" do
        expect(ExchangeRateCache.load.exchange_rates).to eq Hash.new
      end

      it "is stale" do
        expect(ExchangeRateCache.load).to be_stale
      end
    end
  end

  describe "#stale?" do
    def cache_from(time)
      ExchangeRateCache.new(exchange_rates: {}, updated_at: time)
    end

    it "is not stale immediately" do
      expect(cache_from(Time.now)).not_to be_stale
    end

    it "is stale after one hour" do
      expect(cache_from(1.hour.ago)).to be_stale
    end

    it "is not stale after less than one hour" do
      expect(cache_from(59.minutes.ago)).not_to be_stale
    end
  end

  describe "#update" do
    def stale_cache
      ExchangeRateCache.new(exchange_rates: {}, updated_at: 1.hour.ago)
    end

    it "updates the cache" do
      cache = stale_cache

      updated_exchange_rates = {USD: 1.00, GBP: 0.61}
      updated_at = Time.now

      cache.update exchange_rates: updated_exchange_rates, updated_at: updated_at

      expect(cache.exchange_rates).to eq updated_exchange_rates
      expect(cache.updated_at).to eq updated_at
    end

    it "saves the cache" do
      old_cache = stale_cache
      old_cache.save

      updated_exchange_rates = {USD: 1.00, GBP: 0.61}
      updated_at = Time.now

      old_cache.update exchange_rates: updated_exchange_rates, updated_at: updated_at

      new_cache = ExchangeRateCache.load

      expect(new_cache.exchange_rates).to eq updated_exchange_rates
      expect(new_cache.updated_at).to eq updated_at
    end
  end

  describe "#exchange_rate_for" do
    it "fetches the exchange rate for a given currency" do
      cache = ExchangeRateCache.new(exchange_rates: {GBP: 0.61}, updated_at: Time.now)

      expect(cache.exchange_rate_for(:GBP)).to eq 0.61
    end

    it "accepts strings" do
      cache = ExchangeRateCache.new(exchange_rates: {GBP: 0.61}, updated_at: Time.now)

      expect(cache.exchange_rate_for("GBP")).to eq 0.61
    end
  end
end
