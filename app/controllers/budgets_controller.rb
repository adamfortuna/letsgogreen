class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_budget, only: [:show, :edit, :update, :destroy]

  def index
    @budgets = current_user.budgets.order(:title).page(params[:page] || 1).per(50)
  end

  def new
    @budget = current_user.budgets.new
  end

  def create
    @budget = current_user.budgets.new(params[:budget])

    if @budget.save
      redirect_to budgets_path, flash: { notice: 'budget created!' }
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @budget.update_attributes(params[:budget])
      redirect_to budgets_path, flash: { notice: 'budget updated!' }
    else
      render :edit
    end    
  end

  def destroy
    if @budget.destroy
      redirect_to expenses_path flash: { notice: "Your budget was deleted." }
    else
      redirect_to expenses_path flash: { alert: "There was a problem deleting this budget." }
    end
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end
end
