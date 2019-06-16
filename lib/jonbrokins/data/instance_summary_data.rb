require 'jonbrokins/config'
require 'jonbrokins/request'
require 'yaml'
require 'json'

module Jonbrokins
  module InstanceSummaryData
    include Config
    include Request

    def self.get_jenkins_instance_summary(jenkins_instance)
      jenkins_instance_jobs = {
        "Success" => 0,
        "Failed" => 0,
        "InProgress" => 0,
        "Unstable" => 0,
        "Disabled" => 0,
        "Aborted" => 0,
        "NotBuilt" => 0
      }
      target_config = Config.config['jenkins_targets'][jenkins_instance]
      job_summary = Request.get_jobs_status target_config
      if (job_summary.code == 200)
        parsed_json = JSON.parse(job_summary.body)
        parsed_json['jobs'].each_with_index do |job, index|
          case job['color'].downcase # Ball colour defines state
          # https://github.com/jenkinsci/jenkins/blob/master/core/src/main/java/hudson/model/BallColor.java
            when 'red'
              jenkins_instance_jobs['Failed'] = jenkins_instance_jobs['Failed'] += 1
            when /.*_anime/,
              jenkins_instance_jobs['InProgress'] = jenkins_instance_jobs['InProgress'] += 1
            when 'yellow'
              jenkins_instance_jobs['Unstable'] = jenkins_instance_jobs['Unstable'] += 1
            when 'blue'
              jenkins_instance_jobs['Success'] = jenkins_instance_jobs['Success'] += 1
            when 'grey', 'disabled'
              jenkins_instance_jobs['Disabled'] = jenkins_instance_jobs['Disabled'] += 1
            when 'aborted'
              jenkins_instance_jobs['Aborted'] = jenkins_instance_jobs['Aborted'] += 1
            when 'nobuilt'
              jenkins_instance_jobs['NotBuilt'] = jenkins_instance_jobs['NotBuilt'] += 1
          end
        end
      else
        error = "Failed response from #{target_config['host']} : #{job_summary.code}"
        jenkins_instance_jobs[0] = error
      end
      jenkins_instance_jobs
    end
  end
end
