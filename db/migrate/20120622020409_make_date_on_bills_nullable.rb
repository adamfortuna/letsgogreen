class MakeDateOnBillsNullable < ActiveRecord::Migration
  def up
    change_column :bills, :date, :date, null: true
  end

  def down
    change_column :bills, :date, :date, null: false
  end
end
