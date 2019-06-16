require 'jonbrokins/config'
require 'jonbrokins/request'
require 'yaml'
require 'json'

module Jonbrokins
  module SelectJobData
    include Config
    include Request

    # Gets a list of all jenkins jobs from selected index
    def self.get_jenkins_instance_jobs(jenkins_instance)
      jenkins_instance_jobs = {}
      target_config = Config.config['jenkins_targets'][jenkins_instance]
      job_summary = Request.get_jobs_status target_config
      if (job_summary.code == 200)
        parsed_json = JSON.parse(job_summary.body)
        parsed_json['jobs'].each_with_index do |job, index|
          jenkins_instance_jobs[index] = job['name']
        end
      else
        error = "Failed response from #{target_config['host']} : #{job_summary.code}"
        jenkins_instance_jobs[0] = error
      end
      jenkins_instance_jobs
    end
  end
end
