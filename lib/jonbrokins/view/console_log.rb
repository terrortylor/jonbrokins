require "jonbrokins/view/main"
require 'curses'

# Full disclosure, this was adapted from:
# https://github.com/ruby/curses/blob/master/sample/view2.rb

module Jonbrokins
  module View
    class ConsoleLog < Main
      def initialize(height, y_offset)
        super
        set_text
        @window.scrollok(true)
        # set maximum number of y lines, leaving buffer at top and bottom
        @y_max = @window.maxy - (2 * @top_pad)
      end

      # Load the file into memory and
      # put the first part on the curses display.
      def draw
        @window.color_set(Jonbrokins::TUI::COLOUR_LIST_ITEM)
        # set data_lines array
        @data_lines = @text.lines
        # set 'top' of data_lines marker
        @top = 0
        @data_lines[0..@y_max].each_with_index do |line, idx|
          @window.setpos(@top_pad + idx, @left_pad)
          @window.addstr(line)
        end
        @window.setpos(0, @left_pad)
        @window.refresh
        handle_user_input
      end

      # Scroll the display up by one line.
      def scroll_up
        if @top > 0
          @window.scrl(-1)
          @top -= 1
          str = @data_lines[@top+1]
          if str
            @window.setpos(@top_pad, @left_pad)
            @window.addstr(str)
          end
          @window.setpos(@window.maxy-1, 0)
          @window.addstr("".ljust(@window.maxx-1))
          return true
        else
          return false
        end
      end

      # Scroll the display down by one line.
      def scroll_down
        if @top + @y_max < @data_lines.length
          @window.scrl(1)
          @top += 1
          str = @data_lines[@top + @y_max]
          if str
            @window.setpos(@y_max, @left_pad)
            @window.addstr(str)
          end
          @window.setpos(0, @left_pad)
          @window.addstr("".ljust(@window.maxx))
          return true
        else
          return false
        end
      end

      # Allow the user to interact with the display.
      # This uses Emacs-like keybindings, and also
      # vi-like keybindings as well, except that left
      # and right move to the beginning and end of the
      # file, respectively.
      def handle_user_input
        while not @closed
          result = true
          str = @window.getch.to_s
          case str
            when Curses::KEY_DOWN, "j"
              result = scroll_down
            when Curses::KEY_UP, "k"
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
            when Curses::KEY_LEFT, "h"
              while scroll_up
              end
            when Curses::KEY_RIGHT, "l"
              while scroll_down
              end
            when 'q' then close
            when '3' then exit 0 # 3 is ctrl-c
          end
        end
      end

        def set_text
          @text = """
1  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at tellus in arcu
2  posuere vehicula. Suspendisse potenti. Pellentesque at lacus massa. Suspendisse
3  accumsan pretium purus sit amet malesuada. Aenean ut augue scelerisque, auctor
4  libero vel, ultricies lectus. Nam a felis vitae leo aliquet accumsan non sed
5  velit. Sed ac consectetur purus, vitae lobortis ipsum. Curabitur posuere tempus
6  orci eu finibus. Suspendisse efficitur justo in massa rutrum dictum. Curabitur
7  ac eros velit. Duis egestas odio ipsum, egestas efficitur diam tempor at. Etiam
8  in ligula vitae metus elementum lobortis.
9
10 In ex libero, tincidunt quis libero sed, tristique semper sem. Nunc scelerisque
11  vitae felis id convallis. Nullam mattis massa id vehicula blandit. Mauris
12  euismod maximus interdum. Lorem ipsum dolor sit amet, consectetur adipiscing
13  elit. Quisque consequat nisi in finibus auctor. Phasellus imperdiet blandit
14  gravida. Class aptent taciti sociosqu ad litora torquent per conubia nostra,
15  per inceptos himenaeos. Quisque eleifend luctus odio, rhoncus dignissim metus
16  tincidunt sit amet. Donec gravida lorem ut dolor cursus ultricies. Praesent
17  lacus metus, pharetra vel nisl sed, auctor bibendum odio. Nunc varius dignissim
18  bibendum. Sed bibendum accumsan justo, sit amet faucibus velit pellentesque
19  ultrices. Integer porta erat non mauris finibus tincidunt. Ut placerat augue
20  lorem. Sed lorem libero, aliquam et facilisis sit amet, lobortis sed eros.
21
22  Vestibulum elementum massa odio, vitae euismod nisl tincidunt vel. Sed urna
23  felis, interdum nec auctor id, euismod ac orci. Proin eget nisi vel arcu lobortis
24  ultrices id eu neque. Maecenas pretium augue nibh, sit amet fermentum nibh
25  eleifend eget. Vivamus suscipit ultricies fringilla. Nullam rhoncus augue non
26  mi ornare, eget tincidunt lectus convallis. Vestibulum at dui ligula. Pellentesque
27  sodales efficitur neque, eu sollicitudin mauris consectetur sit amet. Phasellus
28  sodales eros arcu, feugiat faucibus elit placerat et.
29
30  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos
31  himenaeos. Nulla sed justo sed ante consectetur pellentesque sit amet in odio.
32  Curabitur vitae faucibus augue. Praesent ut tempor dui, ut iaculis justo. In
33  bibendum eleifend massa eu congue. Sed sodales a lectus nec gravida. Vestibulum
34  ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
35  Vivamus id sollicitudin lorem. Mauris ultrices libero ornare ipsum sagittis,
36  eget accumsan lorem cursus. Ut eu nisl sed justo faucibus sagittis. Quisque eu
37  quam sapien. Curabitur porta justo dolor, eu semper arcu tincidunt ac.
38
39  Nulla vel consectetur arcu. Phasellus a odio ullamcorper erat cursus ullamcorper.
40  Curabitur tincidunt, augue at placerat dignissim, felis libero tempor neque, et
41  rhoncus metus massa a mi. Cras lacinia ultricies aliquet. Maecenas rutrum augue
42  urna, at egestas massa facilisis in. Mauris vel ornare sapien, feugiat egestas
43  ex. Vivamus augue quam, rutrum a molestie nec, auctor ac mi. Ut eleifend convallis
44  elit. Nam ultrices sapien nec lacus sollicitudin, at vestibulum turpis mattis.
45  Suspendisse imperdiet quam lectus, sed hendrerit felis tincidunt at. Sed pulvinar,
46  eros quis malesuada ullamcorper, lacus arcu porta turpis, sit amet aliquet velit
47  dolor non nunc. Praesent ullamcorper est in turpis imperdiet, non rhoncus
48  augue efficitur.
49
50  In ex libero, tincidunt quis libero sed, tristique semper sem. Nunc scelerisque
51  vitae felis id convallis. Nullam mattis massa id vehicula blandit. Mauris
52  euismod maximus interdum. Lorem ipsum dolor sit amet, consectetur adipiscing
53  elit. Quisque consequat nisi in finibus auctor. Phasellus imperdiet blandit
54  gravida. Class aptent taciti sociosqu ad litora torquent per conubia nostra,
55  per inceptos himenaeos. Quisque eleifend luctus odio, rhoncus dignissim metus
56  tincidunt sit amet. Donec gravida lorem ut dolor cursus ultricies. Praesent
57  lacus metus, pharetra vel nisl sed, auctor bibendum odio. Nunc varius dignissim
58  bibendum. Sed bibendum accumsan justo, sit amet faucibus velit pellentesque
59  ultrices. Integer porta erat non mauris finibus tincidunt. Ut placerat augue
60  lorem. Sed lorem libero, aliquam et facilisis sit amet, lobortis sed eros.
61
62  Vestibulum elementum massa odio, vitae euismod nisl tincidunt vel. Sed urna
63  felis, interdum nec auctor id, euismod ac orci. Proin eget nisi vel arcu lobortis
64  ultrices id eu neque. Maecenas pretium augue nibh, sit amet fermentum nibh
65  eleifend eget. Vivamus suscipit ultricies fringilla. Nullam rhoncus augue non
66  mi ornare, eget tincidunt lectus convallis. Vestibulum at dui ligula. Pellentesque
67  sodales efficitur neque, eu sollicitudin mauris consectetur sit amet. Phasellus
68  sodales eros arcu, feugiat faucibus elit placerat et.
69
70  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos
71  himenaeos. Nulla sed justo sed ante consectetur pellentesque sit amet in odio.
72  Curabitur vitae faucibus augue. Praesent ut tempor dui, ut iaculis justo. In
73  bibendum eleifend massa eu congue. Sed sodales a lectus nec gravida. Vestibulum
74  ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
75  Vivamus id sollicitudin lorem. Mauris ultrices libero ornare ipsum sagittis,
76  eget accumsan lorem cursus. Ut eu nisl sed justo faucibus sagittis. Quisque eu
77  quam sapien. Curabitur porta justo dolor, eu semper arcu tincidunt ac.
78
79  Nulla vel consectetur arcu. Phasellus a odio ullamcorper erat cursus ullamcorper.
80  Curabitur tincidunt, augue at placerat dignissim, felis libero tempor neque, et
81  rhoncus metus massa a mi. Cras lacinia ultricies aliquet. Maecenas rutrum augue
82  urna, at egestas massa facilisis in. Mauris vel ornare sapien, feugiat egestas
83  ex. Vivamus augue quam, rutrum a molestie nec, auctor ac mi. Ut eleifend convallis
84  elit. Nam ultrices sapien nec lacus sollicitudin, at vestibulum turpis mattis.
85  Suspendisse imperdiet quam lectus, sed hendrerit felis tincidunt at. Sed pulvinar,
86  eros quis malesuada ullamcorper, lacus arcu porta turpis, sit amet aliquet velit
87  dolor non nunc. Praesent ullamcorper est in turpis imperdiet, non rhoncus
88  augue efficitur.
          """
        end
    end
  end
end
