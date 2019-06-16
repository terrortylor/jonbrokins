require 'yaml'

module Jonbrokins
  module Config

    CONFIG_FILE = "~/.jonbrokins.yml"

    # Returns the configuration
    # Loads it from file if it doesn't exist
    def self.config
      if @conf.nil?
        file_path = File.expand_path(CONFIG_FILE)
        config_file = File.read(file_path)
        @conf = YAML.load(config_file)
      end
      @conf
    rescue
      abort "Could not load configuration file: " if config.nil?
    end
  end
end
