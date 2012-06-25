class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_expense, only: [:edit, :update, :show, :destroy]
  before_filter :setup_form, only: [:edit, :update, :new, :create]
  before_filter :parse_date, only: [:create, :update]

  def index
    @expenses = current_user.expenses.order("date desc")
    @expenses = @expenses.where(budget_id: params[:budget_id]) if params[:budget_id]
    @expenses = @expenses.page(params[:page] || 1).per(50)
  end

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.new(params[:expense])

    debugger
    
    if @expense.save
      redirect_to expenses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update_attributes(params[:expense])
      redirect_to expenses_path, flash: { notice: 'expense updated!' }
    else
      render :edit
    end 
  end

  def show
    @expense = current_user.expenses.find(params[:id])
  end

  def destroy
    if @expense.destroy
      redirect_to expenses_path flash: { notice: "Your expense was deleted." }
    else
      redirect_to expenses_path flash: { alert: "There was a problem deleting this expense." }
    end
  end


  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def setup_form
    @budgets = current_user.budgets.order(:title).all
  end

  def parse_date
    params[:expense][:date] = Date.strptime(params[:expense][:date], "%m/%d/%Y") if params[:expense][:date]
  end
end
