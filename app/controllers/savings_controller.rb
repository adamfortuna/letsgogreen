class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    savings = current_user.savings.order(:title)
    @presenter = SavingsPresenter.new(savings, self)
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

  def destroy
    @saving = current_user.savings.find(params[:id])
    if @saving.destroy
      redirect_to savings_path, flash: { notice: "Your saving was deleted." }
    else
      redirect_to savings_path, flash: { alert: "There was a problem deleting this saving." }
    end
  end

end
