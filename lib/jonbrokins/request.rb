require 'httparty'
require 'uri'

module Jonbrokins
  # Helper class for making calls to Jenkins
  module Request
    def self.get_jobs_status(config)
      HTTParty.get(
          "#{config['host']}/api/json",
          basic_auth: Request.get_basic_auth(config['credentials']),
          headers: Request.get_headers
      )
    end

    def self.get_console_log(config, jenkins_job)
      HTTParty.get(
          "#{config['host']}/job/#{jenkins_job}/lastBuild/console",
          basic_auth: Request.get_basic_auth(config['credentials']),
          headers: Request.get_headers
      )
    end

    private

    def self.get_basic_auth(credentials)
      { username: credentials['user'], password: credentials['api_key'] }
    end

    def self.get_headers
      { Accept: 'application/json' }
    end
  end
end
