class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  has_many :expenses

  has_many :categories
  has_many :bills
  has_many :budgets
  has_many :incomes
  has_many :savings

  has_many :transactions
  has_many :debits
  has_many :credits

  def yearly_income
    yearly_total_for(incomes)
  end

  def yearly_savings
    yearly_total_for(savings)
  end

  def yearly_bills
    yearly_total_for(bills)
  end

  def yearly_budgets
    yearly_total_for(budgets)
  end

  private
  def yearly_total_for(categories)
    categories.inject(0) do |total, category|
      total + category.yearly_amount
    end
  end
end