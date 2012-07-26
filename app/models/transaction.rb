class Transaction < ActiveRecord::Base
  attr_accessible :type, :title, :amount, :date, :description, :category_id, :after_tax, :confirmed

  belongs_to :user
  belongs_to :category

  validates :type, presence: true
  validates :title, presence: true
  validates :amount, presence: true
  validates :date, presence: true

  scope :incomes, joins(:category).where("categories.type = 'Income'")
  scope :savings, joins(:category).where("categories.type = 'Saving'")
  scope :bills, joins(:category).where("categories.type = 'Bill'")
  scope :budgets, joins(:category).where("categories.type = 'Budget'")
end

require_dependency 'credit'
require_dependency 'debit'