class Income < ActiveRecord::Base
  attr_accessible :from, :amount, :date, :description
  belongs_to :user

  validates :from, presence: true
  validates :amount, presence: true
  validates :date, presence: true
end
