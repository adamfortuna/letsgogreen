require 'delegate'

class DashboardPresenter < SimpleDelegator
  attr_reader :controller

  def initialize(model, controller)
    @controller = controller
    super(model)
  end

  def monthly_bill_presenters
    @monthly_bill_presenters ||= monthly_bills.collect do |bill|
      BillPresenter.new(bill, @controller)
    end
  end

  def yearly_bill_presenters
    @yearly_bill_presenters ||= yearly_bills.collect do |bill|
      BillPresenter.new(bill, @controller)
    end
  end


end