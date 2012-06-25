class AddFromIncomeToSavings < ActiveRecord::Migration
  def up
    add_column :savings, :from_before_tax_income, :boolean, default: false
  end
  def down
    remove_column :savings, :from_before_tax_income
  end
end
