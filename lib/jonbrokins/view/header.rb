require "jonbrokins/view/window"
require 'curses'

module Jonbrokins
  module View
    class Header < Window
      def initialize(height, y_offset)
        super
        @window.color_set(Jonbrokins::TUI::COLOUR_HEADER)
      end

      def draw
        @window << "Jonbrokins".center(Curses.cols)
        @window.refresh
      end
    end
  end
end
