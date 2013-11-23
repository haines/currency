require "erb"
require_relative "uid"
require_relative "conversion"
require_relative "../workflow/lib/preferred_currencies"

class Updater
  TEMPLATE_PATH = File.expand_path("template/info.plist.erb", __dir__)
  OUTPUT_PATH = File.expand_path("../workflow/info.plist", __dir__)

  attr_reader :output_uid, :conversions

  def initialize(currencies = PreferredCurrencies.load)
    @output_uid = UID.new
    @conversions = currencies.flat_map do |currency|
      conversions_for(currency.fetch(:symbols))
    end
  end

  def update
    File.write OUTPUT_PATH, render
  end

  def self.update
    new.update
  end

  private

  def render
    ERB.new(File.read(TEMPLATE_PATH)).result(binding)
  end

  def conversions_for(symbols)
    currency_code = symbols.last
    symbols.map {|symbol| Conversion.new(symbol, currency_code) }
  end
end
