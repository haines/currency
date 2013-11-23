require "yaml"

module PreferredCurrencies
  PATH = File.expand_path("../currencies.yml", __dir__)

  def self.load
    YAML.load_file(PATH)
  end
end
