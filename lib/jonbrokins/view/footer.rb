require "jonbrokins/view/window"
require 'curses'

module Jonbrokins
  module View
    class Footer < Window
      def initialize(height, y_offset)
        super
        @window.color_set(Jonbrokins::TUI::COLOUR_HEADER_FOOTER_BAR)
      end

      def draw
        @window << "".rjust(@left_pad) + "j - Up, k - Down, CR - Select, q - Quit".ljust(Curses.cols)
        @window.refresh
      end
    end
  end
end
