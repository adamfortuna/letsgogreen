require 'delegate'

class BudgetPresenter < SimpleDelegator
  attr_reader :controller
  attr_accessor :options

  def initialize(model, controller, options={})
    @controller = controller
    @options = options
    super(model)
  end

  def expenses_total_for_range
    AmountCalculator.amount_for_time_period(expenses, options[:start_date], options[:end_date])
  end

  def expenses_total_for_year
    AmountCalculator.amount_for_time_period(expenses, options[:start_date].beginning_of_year, options[:end_date].end_of_year)
  end
end