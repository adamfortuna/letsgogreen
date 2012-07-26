class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_transaction, only: [:edit, :update, :show, :destroy]
  before_filter :setup_form, only: [:edit, :update, :new, :create]
  before_filter :parse_date, only: [:create, :update]

  def index
    transactions = current_user.transactions.order("date desc").page(params[:page] || 1).per(50)

    if params[:category]
      category = current_user.categories.find(params[:category])
      title = category.to_s
      transactions = transactions.where(category_id: category.id)
    end

    @presenter = TransactionsPresenter.new(self, transactions, title: title)
  end

  def new
    params[:transaction] ||= {}
    params[:transaction][:type] ||= 'Debit'
    @transaction = current_user.transactions.new(params[:transaction])
  end

  def create
    @transaction = current_user.transactions.new(params[:transaction])
    
    if @transaction.save
      redirect_to transactions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction.update_attributes(params[:transaction])
      redirect_to transactions_path, flash: { notice: 'transaction updated!' }
    else
      render :edit
    end 
  end

  def show
    @transaction = current_user.transactions.find(params[:id])
  end

  def destroy
    if @transaction.destroy
      redirect_to transactions_path flash: { notice: "Your transaction was deleted." }
    else
      redirect_to transactions_path flash: { alert: "There was a problem deleting this transaction." }
    end
  end


  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def setup_form
    @budgets = current_user.budgets.order(:title).all
  end

  def parse_date
    params[:transaction][:date] = Date.strptime(params[:transaction][:date], "%m/%d/%Y") if params[:transaction] && params[:transaction][:date]
  end
end
