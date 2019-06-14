require 'curses'

module Jonbrokins
  class Main
    def initialize(main_height, y_offset)
      @window = Curses::Window.new(main_height, 0, y_offset, 0)
      @window.box(?|, ?-)
      @window.color_set(Jonbrokins::TUI::COLOUR_LIST_ITEM)
    end

    def draw
      # Get instances to display
      instances = %w[Main Project1 Project2]
      # Set selected item
      selected_index = 0
      # Set position and show instruction
      @window.setpos(Jonbrokins::TUI::TOP_PAD, Jonbrokins::TUI::LEFT_PAD)
      @window << "Select Jonbrokins Instance: #{@main_height}"
      # Set off set to start selectons from
      option_y_pos_offset = Jonbrokins::TUI::TOP_PAD + 2
      #Begin loop to wait for user selection
      loop do
        # Print jenkins instances
        instances.each.with_index(0) do |str, index|
          # Set position for option
          @window.setpos(option_y_pos_offset + index, Jonbrokins::TUI::LEFT_PAD)
          # If selected index matches current then change text colours
          if index == selected_index
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
        str = @window.getch.to_s
        #Update selection value or exit loop
        case str
          when 'j'
            selected_index = selected_index >= max_index ? max_index : selected_index + 1
          when 'k'
            selected_index = selected_index <= 0 ? 0 : selected_index - 1
          when '10' then exit 0
          when 'q' then exit 0
        end
        # refresh curses output
        @window.refresh
      end
    end
  end
end
