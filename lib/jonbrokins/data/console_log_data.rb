require 'jonbrokins/config'
require 'jonbrokins/request'
require 'nokogiri'

module Jonbrokins
  module ConsoleLogData
    include Config
    include Request

    def self.get_jenkins_job_console_log(jenkins_instance, jenkins_job)
      console_log = ""
      target_config = Config.config['jenkins_targets'][jenkins_instance]
      job_data = Request.get_console_log(target_config, jenkins_job)
      if (job_data.code == 200)
        parsed_data = Nokogiri::HTML.parse(job_data.body)
        puts parsed_data.title

        console_pre =  parsed_data.xpath('//*[@id="main-panel"]/pre')
        console_log =  console_pre.text
      else
        error = "Failed response from #{target_config['host']}/job/#{jenkins_job}/lastBuild/console: #{job_data.code}"
        console_log = error
      end
      console_log
    end
  end
end
