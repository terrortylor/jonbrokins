require "jonbrokins/view/menu"
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
    end
  end
end
