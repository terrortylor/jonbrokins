require "jonbrokins/view/window"
require 'curses'

module Jonbrokins
  module View
    class Main < Window
      def initialize(height, y_offset, controller, model)
        super(height, y_offset)
        @controller = controller
        @model = model
      end

      def draw
        # Set position and show instruction
        @window.setpos(@top_pad, @left_pad)
        @window << "What is the user doing?"
        # refresh curses output
        @window.refresh
      end

      def load_next_view
        #Not Implemented
      end
    end
  end
end
