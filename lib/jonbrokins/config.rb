require 'yaml'

module Jonbrokins
  class Config
    DEFAULT_CONFIG_FILE = '~/.jonbrokins.yml'.freeze
    attr_reader :config

    def initialize(config_path = nil)
      file_path = File.expand_path(config_path || DEFAULT_CONFIG_FILE)
      config_file = File.read(file_path)
      @config = YAML.load(config_file)
    rescue
      raise "Issue loading config file: #{file_path}"
    end

    def config
      @config
    end
  end
end
