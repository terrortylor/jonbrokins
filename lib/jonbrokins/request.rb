require 'httparty'
require 'uri'

module Jonbrokins
  # Helper class for making calls to Jenkins
  module Request
    def Request.get_jobs_status(config)
      HTTParty.get(
          "#{config['host']}/api/json",
          basic_auth: Request.get_basic_auth(config['credentials']),
          headers: Request.get_headers
      )
    end

    private

    def Request.get_basic_auth(credentials)
      { username: credentials['user'], password: credentials['api_key'] }
    end

    def Request.get_headers
      { Accept: 'application/json' }
    end
  end
end
