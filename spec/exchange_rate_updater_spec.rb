require "spec_helper"
require "vcr_helper"
require "exchange_rate_updater"

describe ExchangeRateUpdater do
  around do |example|
    VCR.use_cassette "open_exchange_rates" do
      example.run
    end
  end

  describe "#download" do
    it "returns a hash" do
      expect(ExchangeRateUpdater.new.download).to be_a Hash
    end

    it "gets exchange rates" do
      exchange_rates = ExchangeRateUpdater.new.download.fetch(:exchange_rates)

      expect(exchange_rates).to include USD: 1.00
      expect(exchange_rates).to include :GBP, :EUR, :NZD
    end

    it "gets an update time" do
      updated_at = ExchangeRateUpdater.new.download.fetch(:updated_at)
      downloaded_at = VCR.current_cassette.originally_recorded_at || Time.now

      expect(updated_at).to be_a Time
      expect(updated_at).to be_between downloaded_at - 2.hours, downloaded_at
    end
  end
end
