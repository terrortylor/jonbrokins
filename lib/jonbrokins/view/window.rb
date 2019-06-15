require 'curses'

module Jonbrokins
  module View
    class Window
      def initialize(height, y_offset)
        @height = height
        @y_offset = y_offset
        @closed = false
        @window = Curses::Window.new(@height, 0, @y_offset, 0)
        set_padding
      end

      def set_padding
        @top_pad = 1
        @left_pad = 2
      end

      def draw
        @window << "NOT IMPLEMENTED".center(Curses.cols)
        @window.refresh
      end

      def method_missing(m, *args)
        @window.send(m, *args)
      end

      def close
        @closed = true
        @window.clear
        @window.refresh
        @window.close
      end
    end
  end
end
