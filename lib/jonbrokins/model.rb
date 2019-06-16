module Jonbrokins
  class Model
    attr_reader :jenkins_instances

    def initialize
      @jenkins_instances = {}
    end

    def set_jenkins_instances(jenkins_targets)
      @jenkins_instances = {}
      jenkins_targets.each_with_index do |(key, _), index|
        @jenkins_instances[index] = key
      end
    end
  end
end
