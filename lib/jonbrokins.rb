require "jonbrokins/version"
require "jonbrokins/config"
require "jonbrokins/request"
require "jonbrokins/tui"
require "jonbrokins/view"
require 'json'

module Jonbrokins
  module_function

  def start
    Thread.abort_on_exception = true
    config = Jonbrokins::Config.new.config
    abort "Could not load configuration file: " if config.nil?


    @tui = Jonbrokins::TUI.new
    @tui.draw
    # config['jenkins_targets'].each do |name, config|
    #   puts "Getting Jobs for: #{name}"
    #   job_summary = Jonbrokins::Request.get_jobs_status config
    #   if (job_summary.code == 200)
    #     parsed_json = JSON.parse(job_summary.body)
    #     parsed_json['jobs'].each do |job|
    #       puts "#{job['name']} - #{job['color']}"
    #     end
    #   else
    #     puts "Failed response from #{name} : #{job_summary.code}"
    #   end
    # end
  end
end
