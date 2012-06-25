class MoveBudgetAllocationsToExpenses < ActiveRecord::Migration
  def up
    drop_table :allocations
    add_column :expenses, :budget_id, :integer, null: true
  end

  def down
    create_table :allocations do |t|
      t.timestamps
      t.integer :expense_id, null: false
      t.integer :budget_id, null: false
    end
    remove_column :expenses, :budget_id
  end
end
