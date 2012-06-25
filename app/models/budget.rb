require "scheduleable"

class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :expenses, dependent: :nullify, as: :accountable

  attr_accessible :description, :variable_amount, :title

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :amount, presence: true

  is_scheduleable


  def to_s
    "Budget: #{title}"
  end

  def expenses_amount_for(start_date, end_date)
    expenses.where(date: start_date..end_date).sum(:amount)
  end
end