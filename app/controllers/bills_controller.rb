class BillsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_bill, only: [:edit, :update, :destroy, :show, :pay]

  def index
    bills = current_user.bills.order(:title)
    if params[:schedule] == "monthly"
      bills = bills.monthly
    elsif params[:schedule] == "yearly"
      bills = bills.yearly
    end

    @presenter = BillsPresenter.new(self, bills)
  end

  def new
    @bill = current_user.bills.new
  end

  def create
    @bill = current_user.bills.new(params[:bill])

    if @bill.save
      redirect_to bills_path, flash: { notice: 'Bill created!' }
    else
      render :new
    end
  end

  def show
    @expenses = @bill.expenses.order("date desc").limit(5)
  end

  def edit
  end

  def update
    if @bill.update_attributes(params[:bill])
      redirect_to bills_path, flash: { notice: 'Bill updated!' }
    else
      render :edit
    end    
  end

  def destroy
    if @bill.destroy
      redirect_to expenses_path flash: { notice: "Your bill was deleted." }
    else
      redirect_to expenses_path flash: { alert: "There was a problem deleting this bill." }
    end
  end

  def pay
    @expense = current_user.expenses.new(
      payee: @bill.payee,
      amount: @bill.amount,
      accountable: @bill
    )
  end

  private
  def set_bill
    @bill = current_user.bills.find(params[:id] || params[:bill_id])
  end
end
