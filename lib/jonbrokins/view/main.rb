require "jonbrokins/view/window"
require 'curses'

module Jonbrokins
  module View
    class Main < Window
      def initialize(main_height, y_offset)
        super
        @selected_index = 0
      end

      def handle_user_input(max_index)
        # Capture user input
        str = @window.getch.to_s
        #Update selection value or exit loop
        case str
          when 'j'
            @selected_index = @selected_index >= max_index ? max_index : @selected_index + 1
          when 'k'
            @selected_index = @selected_index <= 0 ? 0 : @selected_index - 1
          when Curses::Key::ENTER then exit 0
          when 'q' then exit 0
        end
      end

      def draw
        # Set position and show instruction
        @window.setpos(@top_pad, @left_pad)
        @window << "What is the user doing?"
        # refresh curses output
        @window.refresh
      end
    end
  end
end
