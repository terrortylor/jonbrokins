require "jonbrokins/view/main"
require 'curses'

module Jonbrokins
  module View
    class Menu < Main
      def initialize(height, y_offset, menu_title)
        super(height, y_offset)
        @menu_title = menu_title
        set_options
        @selected_index = 0
      end

      def set_options
        @options = {}
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
          when '13' # 13 is caridge return
            load_next_view
        when 'q' then close
        when '3' then exit 0 # 3 is ctrl-c
        end
      end

      def draw
        # Set selected item
        #Begin loop to wait for user selection
        while not @closed
          @window.box(?|, ?-)
          @window.color_set(Jonbrokins::TUI::COLOUR_HEADER)
          # Set position and show instruction
          @window.setpos(@top_pad, @left_pad)
          @window << @menu_title
          # Set colour for list items
          @window.color_set(Jonbrokins::TUI::COLOUR_LIST_ITEM)
          # Set off set to start selectons from
          option_y_pos_offset = @top_pad + 2
          # Print jenkins instance tasks
          @options.each do |key, value|
            # Set position for option
            @window.setpos(option_y_pos_offset + key, @left_pad)
            # If selected index matches current then change text colours
            if key == @selected_index
              @window.attron(Curses.color_pair(Jonbrokins::TUI::COLOUR_SELECTED_LIST_ITEM)) {
                @window << "#{key} : #{value}"
              }
            else
              @window << "#{key} : #{value}"
            end
          end
          # Define maximum selecton value
          max_index = @options.size - 1
          # refresh curses output
          @window.refresh
          # Capture user input
          handle_user_input(max_index)
        end
      end
    end
  end
end
