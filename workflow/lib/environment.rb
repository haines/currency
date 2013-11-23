require "yaml"

module Environment
  PATH = File.expand_path("../.env", __dir__)

  def self.load
    ENV.update YAML.load_file(PATH)
  end
end
