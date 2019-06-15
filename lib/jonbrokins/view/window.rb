require 'curses'

module Jonbrokins
  module View
    class Window
      def initialize(height, y_offset)
        @window = Curses::Window.new(height, 0, y_offset, 0)
        set_padding
      end

      def set_padding
        @top_pad = 1
        @left_pad = 2
      end

      def draw
        @window << "NOT IMPLEMENTED".center(Curses.cols)
        # @window.addstr("NOT IMPLEMENTED".center(Curses.cols))
        @window.refresh
      end

      def method_missing(m, *args)
        @window.send(m, *args)
      end
    end
  end
end
