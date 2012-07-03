require 'delegate'

class IncomePresenter < SimpleDelegator
  attr_reader :controller
  attr_accessor :options

  def initialize(model, controller, options={})
    @controller = controller
    @options = options
    super(model)
  end
end