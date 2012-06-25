class ChangeExpenseAssociationToPolymorphic < ActiveRecord::Migration
  def up
    rename_column :expenses, :budget_id, :account_id
    add_column :expenses, :account_type, :string
    remove_column :expenses, :bill_id

    execute "UPDATE expenses SET account_type='Budget'"
  end

  def down
    rename_column :expenses, :account_id, :budget_id
    add_column :expenses, :bill_id, :integer
    remove_column :expenses, :account_type
  end
end
