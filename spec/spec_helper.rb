$: << File.expand_path("../workflow/lib", __dir__)

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
end
