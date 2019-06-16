require "jonbrokins/view/menu"
require "jonbrokins/view/select_instance_task"
require "jonbrokins/data/select_instance_data"
require 'curses'

module Jonbrokins
  module View
    class SelectInstance < Menu
      include SelectInstanceData

      def initialize(height, y_offset)
        super
        @menu_title =  "Select Jonbrokins Instance:"
      end

      def set_options
        @options = SelectInstanceData.get_jenkins_instances
      end

      def load_next_view
        task_select = Jonbrokins::View::SelectInstanceTask.new(@height, @y_offset, @options[@selected_index])
        task_select.draw
      end
    end
  end
end
