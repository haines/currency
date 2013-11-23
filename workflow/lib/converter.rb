require "currency_provider"
require "parser"

class Converter
  def initialize(currencies = CurrencyProvider.currencies, parser = Parser.new(currencies))
    @currencies = currencies
    @parser = parser
  end

  def convert(input)
    from = parser.parse(input)
    return [] unless from
    currencies_except(from.currency).map {|currency| from.convert_to(currency) }
  end

  private

  attr_reader :currencies, :parser

  def currencies_except(excluded)
    currencies.reject {|currency| currency == excluded }
  end
end
