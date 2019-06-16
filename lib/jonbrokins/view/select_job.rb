require "jonbrokins/view/menu"
require "jonbrokins/view/console_log"
require "jonbrokins/data/select_job_data"
require 'curses'

module Jonbrokins
  module View
    class SelectJob < Menu
      include SelectJobData

      def initialize(height, y_offset, jenkins_instance)
        @jenkins_instance = jenkins_instance
        @menu_title =  "Select Jonbrokins Job:"
        super(height, y_offset)
      end

      def set_options
        @options = SelectJobData.get_jenkins_instance_jobs @jenkins_instance
      end

      def load_next_view
        console_log = Jonbrokins::View::ConsoleLog.new(@height, @y_offset, @jenkins_instance)
        console_log.draw
      end
    end
  end
end
