require 'jonbrokins/config'

module Jonbrokins
  module SelectInstanceData
    include Config

    def self.get_jenkins_instances
      jenkins_instances = {}
      Config.config['jenkins_targets'].each_with_index do |(key, _), index|
        jenkins_instances[index] = key
      end
      jenkins_instances
    end
  end
end
