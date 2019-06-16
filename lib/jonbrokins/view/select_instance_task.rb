require "jonbrokins/view/menu"
require "jonbrokins/view/select_job"
require "jonbrokins/view/instance_summary"
require 'curses'

module Jonbrokins
  module View
    class SelectInstanceTask < Menu

      def initialize(height, y_offset, jenkins_instance)
        super(height, y_offset)
        @menu_title =  "Select Jonbrokins Task: #{jenkins_instance}"
        @jenkins_instance = jenkins_instance
      end

      def set_options
        @options = {
          0 => "Job Summary",
          1 => "List Jobs"
        }
      end

      def load_next_view
        case @selected_index
          when 0
            instance_summary = Jonbrokins::View::InstanceSummary.new(@height, @y_offset, @jenkins_instance)
            instance_summary.draw
          when 1
            list_jobs = Jonbrokins::View::SelectJob.new(@height, @y_offset, @jenkins_instance)
            list_jobs.draw
        end
      end
    end
  end
end
