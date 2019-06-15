require "jonbrokins/view/main"
require 'curses'

module Jonbrokins
  module View
    class SelectInstance < Main
      def initialize(main_height, y_offset)
        super
      end

      def draw
        @window.box(?|, ?-)
        @window.color_set(Jonbrokins::TUI::COLOUR_LIST_ITEM)
        # Get instances to display
        instances = %w[Main Project1 Project2]
        # Set selected item
        selected_index = 0
        # Set position and show instruction
        @window.setpos(@top_pad, @left_pad)
        @window << "Select Jonbrokins Instance: #{@main_height}"
        # Set off set to start selectons from
        option_y_pos_offset = @top_pad + 2
        #Begin loop to wait for user selection
        loop do
          # Print jenkins instances
          instances.each.with_index(0) do |str, index|
            # Set position for option
            @window.setpos(option_y_pos_offset + index, @left_pad)
            # If selected index matches current then change text colours
            if index == @selected_index
              @window.attron(Curses.color_pair(Jonbrokins::TUI::COLOUR_SELECTED_LIST_ITEM)) {
                @window << "#{index} : #{str}"
              }
            else
              @window << "#{index} : #{str}"
            end
          end
          # Define maximum selecton value
          max_index = instances.size - 1
          # Capture user input
          handle_user_input(max_index)
          # refresh curses output
          @window.refresh
        end
      end
    end
  end
end
