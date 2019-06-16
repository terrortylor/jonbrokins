require "jonbrokins/version"
require "jonbrokins/tui"

module Jonbrokins
  module_function

  def start
    Thread.abort_on_exception = true

    tui = Jonbrokins::TUI.new()
    tui.draw
  end
end
