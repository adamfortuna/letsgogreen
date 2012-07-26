require 'delegate'

class BillsPresenter < SimpleDelegator
  attr_reader :controller

  attr_accessor :bills

  def initialize(controller, bills)
    @controller = controller
    self.bills = bills
  end

  def bills=(bills)
    @internal_bills = bills
    @bills = bills.collect do |bill|
      BillPresenter.new(bill, controller)
    end
  end

  def monthly_total
    @internal_bills.inject(0) do |total, bill|
      total + bill.monthly_amount
    end
  end

  def yearly_total
    @internal_bills.inject(0) do |total, bill|
      total + bill.yearly_amount
    end
  end

  def bill_spend_rate
    yearly_total / @controller.current_user.yearly_income * 100
  end
end

