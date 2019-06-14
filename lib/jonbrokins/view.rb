module Jonbrokins
  module View

    # Returns the human readable names of the
    # Jenkins instances from the config file
    def self.jenkins_instances(config)
        config['jenkins_targets'].keys
    end
  end
end
