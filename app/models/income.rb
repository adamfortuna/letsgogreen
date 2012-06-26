require "scheduleable"

class Income < ActiveRecord::Base
  attr_accessible :name, :amount, :date, :description
  belongs_to :user

  validates :name, presence: true
  validates :date, presence: true

  is_scheduleable

  after_initialize :set_default_date


  def set_default_date
    self.date ||= Date.today.strftime('%m/%d/%Y')
  end
  private :set_default_date
end
