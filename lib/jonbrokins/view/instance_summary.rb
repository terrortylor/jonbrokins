require "jonbrokins/view/main"
require "jonbrokins/data/instance_summary_data"
require 'curses'

module Jonbrokins
  module View
    class InstanceSummary < Main
      include InstanceSummaryData

      def initialize(height, y_offset, jenkins_instance)
        @window_title = "Jonbrokins Instance Job Summary: #{jenkins_instance}"
        @jenkins_instance = jenkins_instance
        set_summary
        super(height, y_offset)
      end

      def set_summary
        # @summary = {
        #   "Success" => 0,
        #   "Failed" => 0,
        #   "InProgress" => 0,
        #   "Unstable" => 0,
        #   "Disabled" => 0,
        #   "Aborted" => 0,
        #   "NotBuilt" => 0
        # }
        @summary = InstanceSummaryData.get_jenkins_instance_summary @jenkins_instance
      end

      def handle_user_input()
        # Capture user input
        str = @window.getch.to_s
        #Update selection value or exit loop
        case str
          when 'q' then close
          when '3' then exit 0 # 3 is ctrl-c
        end
      end

      def draw
        #Get length of max key for formatting
        keys = @summary.keys
        max_length=0
        keys.each do |i|
          max_length = max_length < i.length ? i.length : max_length
        end
        #Begin loop to wait for user selection
        while not @closed
          @window.box(?|, ?-)
          @window.color_set(Jonbrokins::TUI::COLOUR_HEADER)
          # Set position and show instruction
          @window.setpos(@top_pad, @left_pad)
          @window << @window_title
          # Set colour for items
          @window.color_set(Jonbrokins::TUI::COLOUR_LIST_ITEM)
          # Set off set to start selectons from
          option_y_pos_offset = @top_pad + 2
          # Print jenkins instance summary
          @summary.each do |key, value|
            @window.setpos(option_y_pos_offset, @left_pad)
            @window << "#{key.ljust(max_length)} : #{value}"
            option_y_pos_offset += 1
          end
          # refresh curses output
          @window.refresh
          # Capture user input
          handle_user_input()
        end
      end
    end
  end
end
