require 'delegate'

class SavingsPresenter < SimpleDelegator
  attr_reader :controller

  attr_accessor :savings

  def initialize(savings, controller)
    @controller = controller
    self.savings = savings
  end

  def savings=(savings)
    @internal_savings = savings
    @savings = savings.collect do |saving|
      SavingPresenter.new(saving, controller)
    end
  end

  def monthly_total
    @monthly_total ||= @internal_savings.inject(0) do |total, saving|
      total + saving.monthly_amount
    end
  end

  def yearly_total
    yearly_total ||= @internal_savings.inject(0) do |total, saving|
      total + saving.yearly_amount
    end
  end

  def savings_rate
    yearly_total / @controller.current_user.yearly_income * 100
  end
end

