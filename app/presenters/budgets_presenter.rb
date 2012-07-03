require 'delegate'

class BudgetsPresenter < SimpleDelegator
  attr_reader :controller

  attr_accessor :budgets, :budget_presenters, :options

  def initialize(budgets, controller, options={})
    @controller = controller
    @options = options
    self.budgets = budgets
  end

  def budgets=(budgets)
    @budgets = budgets
    @budget_presenters = budgets.collect do |budget|
      BudgetPresenter.new(budget, controller, options)
    end
  end

  def start_date
    options[:start_date]
  end

  def end_date
    options[:end_date]
  end

  def period_name
    if start_date.month == end_date.month
      start_date.strftime "%B %Y"

    end
  end

  def expense_total
    ids = budgets.collect(&:id)
    @controller
      .current_user
      .expenses
      .where(accountable_type: 'Budget', accountable_id: ids)
      .where(date: start_date..end_date)
      .sum(:amount)
  end

  def monthly_budget
    @monthly_budget = budgets.monthly.sum(:amount)
  end

  def yearly_budget
    @yearly_budget = budgets.yearly.sum(:amount)
  end
end