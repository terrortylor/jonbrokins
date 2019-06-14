require 'curses'

module Jonbrokins
  class Header

    def initialize(header_height)
      @window = Curses::Window.new(header_height, 0, 0, 0)
      @window.color_set(Jonbrokins::TUI::COLOUR_HEADER)
    end

    def draw
      @window << "Jonbrokins".center(Curses.cols)
      @window.refresh
    end
  end
end
