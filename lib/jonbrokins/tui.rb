require "jonbrokins/footer"
require "jonbrokins/header"
require "jonbrokins/main"
require 'curses'

module Jonbrokins
  class TUI
    # Padding options
    TOP_PAD = 1
    LEFT_PAD = 2

    # Colour scheme mappings
    COLOUR_HEADER = 1
    COLOUR_LIST_ITEM = 2
    COLOUR_SELECTED_LIST_ITEM = 3

    def initialize
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
        @header = Jonbrokins::Header.new(@header_footer_height)
        @header.draw
        @footer = Jonbrokins::Footer.new(@header_footer_height, @main_height + @header_footer_height)
        @footer.draw
        @main = Jonbrokins::Main.new(@main_height, @header_footer_height)
        @main.draw
      ensure
        # sleep 1
        Curses.close_screen
      end
    end

    private

    def init_colour_pairs
      Curses.init_pair(COLOUR_HEADER, Curses::COLOR_BLACK, Curses::COLOR_RED)
      Curses.init_pair(COLOUR_LIST_ITEM, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
      Curses.init_pair(COLOUR_SELECTED_LIST_ITEM, Curses::COLOR_RED, Curses::COLOR_BLACK)
    end
  end
end
