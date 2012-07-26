class IncomesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_income, only: [:edit, :update, :show, :destroy]
  before_filter :parse_date, only: [:create, :update]

  def index
    incomes = current_user.incomes.order(:title)
    @presenter = IncomesPresenter.new(incomes, self)
  end

  def new
    @income = current_user.incomes.new
  end

  def create
    @income = current_user.incomes.new(params[:income])

    if @income.save
      redirect_to incomes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @income.update_attributes(params[:income])
      redirect_to incomes_path, flash: { notice: 'income updated!' }
    else
      render :edit
    end    
  end

  def destroy
    if @income.destroy
      redirect_to incomes_path, flash: { notice: "Your income was deleted." }
    else
      redirect_to incomes_path, flash: { alert: "There was a problem deleting this income." }
    end
  end


  private

  def set_income
    @income = current_user.incomes.find(params[:id])
  end

  def parse_date
    params[:income][:date] = Date.strptime(params[:income][:date], "%m/%d/%Y") if params[:income][:date]
  end
end
