require_relative "uid"

Conversion = Struct.new(:symbol, :currency_code, :uid) do
  def initialize(symbol, currency_code)
    super(symbol, currency_code, UID.new)
  end
end
