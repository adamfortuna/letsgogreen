class Saving < ActiveRecord::Base
  SCHEDULES = %w(Monthly Yearly).freeze

  belongs_to :user

  attr_accessible :amount, :description, :schedule, :variable_amount, :title, :from_before_tax_income

  validates :title, presence: true
  validates :amount, presence: true
  validates :schedule, presence: true, inclusion: { in: SCHEDULES }

  scope :monthly, where(schedule: 'Monthly')
  scope :yearly, where(schedule: 'Yearly')

  def self.default_schedule
    SCHEDULES.first
  end

  def yearly?
    schedule == "Yearly"
  end

  def monthly_amount
    yearly? ? (amount/12) : amount
  end

  def yearly_amount
    yearly? ? amount : (amount * 12)
  end
end