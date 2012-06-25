class Expense < ActiveRecord::Base
  attr_accessible :payee, :amount, :date, :description, :budget_id, :accountable_id_and_type, :accountable

  belongs_to :user
  belongs_to :accountable, polymorphic: true

  after_initialize :set_default_date

  validates :payee, presence: true
  validates :amount, presence: true
  validates :date, presence: true

  def accountable_id_and_type
    "#{accountable_type}-#{accountable_id}" if accountable_id && accountable_type
  end

  def accountable_id_and_type=(account_and_type)
    self.accountable_type, self.accountable_id = account_and_type.split("-")
  end

  def set_default_date
    self.date ||= Date.today.strftime('%m/%d/%Y')
  end
  private :set_default_date
end