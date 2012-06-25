class CreateAllocations < ActiveRecord::Migration
  def up
    create_table :allocations do |t|
      t.timestamps
      t.integer :expense_id, null: false
      t.integer :budget_id, null: false
    end
  end

  def down
    drop_table :allocations
  end
end
