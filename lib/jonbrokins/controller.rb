require 'yaml'

module Jonbrokins
  class Controller
    CONFIG_FILE = "~/.jonbrokins.yml"

    def initialize(model)
      @model = model
    end

    def load_jenkins_instances
      @model.set_jenkins_instances(config['jenkins_targets'])
    end

    def load_instance_jobs_overview
      config['jenkins_targets'].each do |name, config|
        job_summary = Jonbrokins::Request.get_jobs_status config
        if (job_summary.code == 200)
          parsed_json = JSON.parse(job_summary.body)
          parsed_json['jobs'].each do |job|
          end
        else
          puts "Failed response from #{name} : #{job_summary.code}"
        end
      end
    end

    private

    def config
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
