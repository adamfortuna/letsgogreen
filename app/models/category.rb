require "scheduleable"

class Category < ActiveRecord::Base
  SCHEDULES = %w(Monthly Yearly).freeze

  belongs_to :user
  has_many :transactions, dependent: :nullify

  attr_accessible :description, :variable_amount, :title, :after_tax, :alias

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :amount, presence: true

  is_scheduleable
  validates :schedule, presence: true, inclusion: { in: schedules }

  def expenses_amount_for(start_date, end_date)
    expenses.where(date: start_date..end_date).sum(:amount)
  end

  def to_s
    "#{self.class.to_s}: #{title}"
  end
end

require_dependency 'bill'
require_dependency 'budget'
require_dependency 'income'
require_dependency 'saving'