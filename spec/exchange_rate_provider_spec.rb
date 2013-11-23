require "spec_helper"
require "exchange_rate_provider"

describe ExchangeRateProvider do
  context "with a fresh cache" do
    it "provides exchange rates" do
      cache = double("exchange_rate_cache", stale?: false)
      allow(cache).to receive(:exchange_rate_for).with(:GBP).and_return(0.61)
      provider = ExchangeRateProvider.new(cache, double("exchange_rate_updater"))

      expect(provider.exchange_rate_for(:GBP)).to eq 0.61
    end
  end

  context "with a stale cache" do
    it "updates the cache" do
      cache = double("exchange_rate_cache", stale?: true, exchange_rate_for: nil, update: nil)

      response = {exchange_rates: {GBP: 0.61}, updated_at: Time.now}
      updater = double("exchange_rate_updater", download: response)

      ExchangeRateProvider.new(cache, updater).exchange_rate_for(:GBP)

      expect(cache).to have_received(:update).with(response)
    end
  end
end
