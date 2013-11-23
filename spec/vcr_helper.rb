require "vcr"

VCR.configure do |vcr|
  vcr.cassette_library_dir = File.expand_path("fixtures", __dir__)
  vcr.hook_into :webmock
end
