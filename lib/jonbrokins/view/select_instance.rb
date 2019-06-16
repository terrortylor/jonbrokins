require "jonbrokins/view/menu"
require "jonbrokins/view/select_instance_task"
require "jonbrokins/controller"
require 'curses'

module Jonbrokins
  module View
    class SelectInstance < Menu
      def initialize(height, y_offset, controller, model)
        super(height, y_offset, controller, model)
        @menu_title =  "Select Jonbrokins Instance:"
      end

      def set_options
        @controller.load_jenkins_instances
        @options = @model.jenkins_instances
      end

      def load_next_view
        task_select = Jonbrokins::View::SelectInstanceTask.new(@height, @y_offset, @controller, @model)
        task_select.draw
      end
    end
  end
end
