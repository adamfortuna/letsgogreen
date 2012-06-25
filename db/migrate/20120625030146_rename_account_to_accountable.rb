class RenameAccountToAccountable < ActiveRecord::Migration
  def up
    rename_column :expenses, :account_id, :accountable_id
    rename_column :expenses, :account_type, :accountable_type
  end

  def down
    rename_column :expenses, :accountable_id, :account_id
    rename_column :expenses, :accountable_type, :account_type
  end
end
