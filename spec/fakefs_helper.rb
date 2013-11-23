require "fakefs/spec_helpers"

module FakeFSHelper
  def fake_directory_containing(file)
    include FakeFS::SpecHelpers
    before { FakeFS::FileSystem.add File.dirname(file) }
  end
end

RSpec.configure do |rspec|
  rspec.extend FakeFSHelper
end
