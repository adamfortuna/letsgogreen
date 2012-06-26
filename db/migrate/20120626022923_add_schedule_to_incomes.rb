class AddScheduleToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :schedule, :string
  end
end
