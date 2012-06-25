require "scheduleable"

class Bill < ActiveRecord::Base
  belongs_to :user
  has_many :expenses, as: :accountable, dependent: :nullify
  attr_accessible :payee, :description, :variable_amount, :title, :date
  validates :payee, presence: true

  after_initialize :set_default_date


  is_scheduleable

  def to_s
    "Bill: #{display_title}"
  end

  def display_title
    title.blank? ? payee : title
  end


  def set_default_date
    self.date = Date.today.strftime('%m/%d/%Y')
  end
  private :set_default_date
end