require "jonbrokins/view/menu"
require "jonbrokins/view/select_instance_task"
require 'curses'

module Jonbrokins
  module View
    class SelectInstance < Menu
      def initialize(height, y_offset)
        super(height, y_offset, "Select Jonbrokins Instance:")
      end

      def set_options
        @options = {
          0 => "Main",
          1 => "Project1",
          2 => "Project2"
        }
      end

      def load_next_view
        task_select = Jonbrokins::View::SelectInstanceTask.new(@height, @y_offset)
        task_select.draw
      end
    end
  end
end
