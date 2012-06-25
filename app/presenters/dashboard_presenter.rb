require 'delegate'

class DashboardPresenter < SimpleDelegator
  attr_reader :controller

  def initialize(model, controller)
    @controller = controller
    super(model)
  end
end