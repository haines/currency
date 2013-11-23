require "money"

class Parser
  def initialize(currencies)
    @currencies = currencies
  end

  def parse(input)
    pattern.match(input) do |matched|
      Money.new(matched[:amount].to_f, currency_for(matched[:symbol]))
    end
  end

  private

  attr_reader :currencies

  def pattern
    symbol = named_group(:symbol, any_of(symbols))
    amount = named_group(:amount, '\d*\.?\d*')

    /\A#{symbol}\s*#{amount}\Z/
  end

  def currency_for(symbol)
    currencies.find {|currency| currency.symbols.include?(symbol) }
  end

  def symbols
    currencies.flat_map(&:symbols)
  end

  def named_group(name, pattern)
    "(?<#{name}>#{pattern})"
  end

  def any_of(items)
    items.map {|item| Regexp.quote(item) }.join("|")
  end
end
