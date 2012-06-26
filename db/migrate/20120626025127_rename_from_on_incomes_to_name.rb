class RenameFromOnIncomesToName < ActiveRecord::Migration
  def up
    rename_column :incomes, :from, :name
  end

  def down
    rename_column :incomes, :name, :from
  end
end
