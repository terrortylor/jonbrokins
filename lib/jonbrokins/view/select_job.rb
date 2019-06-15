require "jonbrokins/view/menu"
require 'curses'

module Jonbrokins
  module View
    class SelectJob < Menu
      def initialize(height, y_offset)
        super(height, y_offset, "Select Jonbrokins Job:")
      end

      def set_options
        @options = {
          0 => "Job 1",
          1 => "Job 2",
          2 => "Job 3"
        }
      end
    end
  end
end
