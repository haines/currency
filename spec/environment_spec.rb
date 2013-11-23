require "spec_helper"
require "fakefs_helper"
require "environment"

describe Environment do
  fake_directory_containing Environment::PATH

  it "loads environment variables" do
    File.write Environment::PATH, "TEST_VARIABLE: test value\n"

    Environment.load

    expect(ENV["TEST_VARIABLE"]).to eq "test value"
  end
end
