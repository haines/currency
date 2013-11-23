Money = Struct.new(:amount, :currency) do
  def convert_to(other_currency)
    Money.new(amount * exchange_rate_with(other_currency), other_currency)
  end

  def to_s
    "%s\u2009%.2f" % [currency.symbol, amount]
  end

  private

  def exchange_rate_with(other_currency)
    other_currency.exchange_rate / currency.exchange_rate
  end
end
