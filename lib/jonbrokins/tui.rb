require "jonbrokins/view/footer"
require "jonbrokins/view/header"
require "jonbrokins/view/select_instance"
require 'curses'

module Jonbrokins
  class TUI
    # Colour scheme mappings
    COLOUR_HEADER_FOOTER_BAR = 1
    COLOUR_HEADER = 2
    COLOUR_LIST_ITEM = 3
    COLOUR_SELECTED_LIST_ITEM = 4

    def initialize()
      Curses.noecho
      Curses.nonl
      Curses.stdscr.keypad(true)
      Curses.raw
      Curses.stdscr.nodelay = 1
      Curses.init_screen
      Curses.start_color
      Curses.curs_set(0) # Hides the cursor
      #Set up some default dimension
      @header_footer_height = 1
      @main_height = Curses.lines - (@header_footer_height * 2)
    end

    def draw
      init_colour_pairs
      begin
        @header = Jonbrokins::View::Header.new(@header_footer_height, 0)
        @header.draw
        @footer = Jonbrokins::View::Footer.new(@header_footer_height, @main_height + @header_footer_height)
        @footer.draw
        @main = Jonbrokins::View::SelectInstance.new(@main_height, @header_footer_height)
        @main.draw
      ensure
        # sleep 1
        Curses.close_screen
      end
    end

    private

    def init_colour_pairs
      Curses.init_pair(COLOUR_HEADER_FOOTER_BAR, Curses::COLOR_BLACK, Curses::COLOR_RED)
      Curses.init_pair(COLOUR_HEADER, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
      Curses.init_pair(COLOUR_LIST_ITEM, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
      Curses.init_pair(COLOUR_SELECTED_LIST_ITEM, Curses::COLOR_RED, Curses::COLOR_BLACK)
    end
  end
end
