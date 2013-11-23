Currency = Struct.new(:name, :exchange_rate, :symbols) do
  def initialize(name, exchange_rate, *symbols)
    super(name, exchange_rate, symbols)
  end

  def symbol
    symbols.first
  end
end
