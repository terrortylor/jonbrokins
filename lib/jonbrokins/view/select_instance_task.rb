require "jonbrokins/view/menu"
require "jonbrokins/view/select_job"
require 'curses'

module Jonbrokins
  module View
    class SelectInstanceTask < Menu
      def initialize(height, y_offset)
        super(height, y_offset, "Select Jonbrokins Task:")
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
            # Not Implemented
          when 1
            list_jobs =Jonbrokins::View::SelectJob.new(@height, @y_offset)
            list_jobs.draw
        end
      end
    end
  end
end
