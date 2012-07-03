require 'delegate'

class IncomesPresenter < SimpleDelegator
  attr_reader :controller

  attr_accessor :incomes

  def initialize(incomes, controller)
    @controller = controller
    self.incomes = incomes
  end

  def incomes=(incomes)
    @internal_incomes = incomes
    @incomes = incomes.collect do |income|
      IncomePresenter.new(income, controller)
    end
  end

  def monthly_total
    @internal_incomes.inject(0) do |total, income|
      total + income.monthly_amount
    end
  end

  def yearly_total
    @internal_incomes.inject(0) do |total, income|
      total + income.yearly_amount
    end
  end
end

