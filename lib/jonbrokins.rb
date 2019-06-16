require "jonbrokins/version"
require "jonbrokins/tui"
require "jonbrokins/model"
require "jonbrokins/controller"
require 'json'

module Jonbrokins
  module_function

  def start
    Thread.abort_on_exception = true

    model = Jonbrokins::Model.new
    controller = Jonbrokins::Controller.new(model)
    tui = Jonbrokins::TUI.new(controller, model)
    tui.draw
  end
end
