require "jonbrokins/view/main"
require "jonbrokins/data/console_log_data"
require 'curses'

# Full disclosure, this was adapted from:
# https://github.com/ruby/curses/blob/master/sample/view2.rb

module Jonbrokins
  module View
    class ConsoleLog < Main
      def initialize(height, y_offset, jenkins_instance, jenkins_job)
        super(height, y_offset)
        @window.scrollok(true)
        # set maximum number of y lines, leaving buffer at top and bottom
        # taking into account first item is 0
        @y_max = @window.maxy - ((2 * @top_pad) + 1)
        @x_max_console_length = @window.maxx - ((2 * @left_pad) + 1)
        @jenkins_instance = jenkins_instance
        @jenkins_job = jenkins_job
        set_text
      end

      def debug_status
        @window.setpos(0, @left_pad)
        @window << "wind x: #{@window.maxx}/#{@x_max_console_length} : wind y: #{@window.maxy}/#{@y_max} : top_pad: #{@top_pad} : left_pad: #{@left_pad} : y_offset: #{@y_offset} : top: #{@top}"
      end

      def set_text
        @text = ConsoleLogData.get_jenkins_job_console_log(@jenkins_instance, @jenkins_job)
      end

      # Load the file into memory and
      # put the first part on the curses display.
      def draw
        @window.color_set(Jonbrokins::TUI::COLOUR_LIST_ITEM)
        # set data_lines array
        if @text.nil?
          @data_lines = ["No data returned"]
        else
          @data_lines = @text.lines
        end
        # set 'top' of data_lines marker
        @top = 0
        @data_lines[0..@y_max].each_with_index do |line, idx|
          @window.setpos(@top_pad + idx, @left_pad)
          @window.addstr(line[0..@x_max_console_length])
        end
        # debug_status
        @window.refresh
        handle_user_input
      end

      # Scroll the display up by one line.
      def scroll_up
        if @top > 0
          @window.scrl(-1)
          @top -= 1
          line = @data_lines[@top]
          if line
            @window.setpos(@top_pad, @left_pad)
            @window.addstr(line[0..@x_max_console_length])
          end
          @window.setpos(@window.maxy-1, 0)
          @window.addstr("".ljust(@window.maxx - 1))
          # debug_status
          return true
        else
          return false
        end
      end

      # Scroll the display down by one line.
      def scroll_down
        if @top + @y_max + 1< @data_lines.length
          @window.scrl(1)
          @top += 1
          line = @data_lines[@top + @y_max]
          if line
            @window.setpos(@y_max + 1, @left_pad)
            @window.addstr(line[0..@x_max_console_length])
          end
          @window.setpos(0, @left_pad)
          @window.addstr("".ljust(@window.maxx - 1))
          # debug_status
          return true
        else
          return false
        end
      end

      # Allow the user to interact with the display.
      # This uses vi-like keybindings.
      # Space to select.
      def handle_user_input
        while not @closed
          result = true
          str = @window.getch.to_s
          case str
            when "j"
              result = scroll_down
            when "k"
              result = scroll_up
            when "f"
              (@y_max).times do |i|
                if !scroll_down && i == 0
                  result = false
                  break
                end
              end
            when "b"
              (@y_max).times do |i|
                if !scroll_up && i == 0
                  result = false
                  break
                end
              end
            when "h"
              while scroll_up
              end
            when "l"
              while scroll_down
              end
            when 'q' then close
            when '3' then exit 0 # 3 is ctrl-c
          end
        end
      end
    end
  end
end
