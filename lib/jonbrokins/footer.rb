require 'curses'

module Jonbrokins
  class Footer
    LEFT_PAD = 2

    def initialize(footer_height, y_offset)
      @window = Curses::Window.new(footer_height, 0, y_offset, 0)
      @window.color_set(Jonbrokins::TUI::COLOUR_HEADER)
    end

    def draw
      # @window.setpos(Jonbrokins::TUI::LEFT_PAD, 0)
      @window << "".rjust(Jonbrokins::TUI::LEFT_PAD) + "j - Up, k - Down, CR - Select, q - Quit".ljust(Curses.cols)
      @window.refresh
    end
  end
end
