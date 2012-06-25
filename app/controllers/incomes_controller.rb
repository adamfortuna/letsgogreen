class IncomesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @incomes = current_user.incomes
  end

  def new
    @income = current_user.incomes.new(date: Time.now)
  end

  def create
    @income = current_user.incomes.new(params[:income])

    if @income.save
      redirect_to incomes_path
    else
      render :new
    end
  end
end
