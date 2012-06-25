class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @savings = current_user.savings.order("amount desc").page(params[:page] || 1).per(50)
  end

  def new
    @saving = current_user.savings.new
  end

  def create
    @saving = current_user.savings.new(params[:saving])

    if @saving.save
      redirect_to savings_path, flash: { notice: 'Savings created!' }
    else
      render :new
    end
  end

  def show
    @saving = current_user.savings.find(params[:id])
  end

  def edit
    @saving = current_user.savings.find(params[:id])
  end

  def update
    @saving = current_user.savings.find(params[:id])
    if @saving.update_attributes(params[:saving])
      redirect_to savings_path, flash: { notice: 'Savings updated!' }
    else
      render :edit
    end
    
  end
end
