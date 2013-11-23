require "spec_helper"
require "fakefs_helper"
require "preferred_currencies"

describe PreferredCurrencies do
  fake_directory_containing PreferredCurrencies::PATH

  it "loads currency data" do
    currencies = [{name: "US dollar", symbols: ["$", "USD"]}, {name: "Pound sterling", symbols: ["£", "GBP"]}]
    File.write PreferredCurrencies::PATH, currencies.to_yaml

    expect(PreferredCurrencies.load).to eq currencies
  end
end
