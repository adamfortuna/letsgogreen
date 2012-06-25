class CreateBudgets < ActiveRecord::Migration
  def up
    create_table :budgets do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.string :title, null: false
      t.decimal :amount, null: false
      t.text :description
      t.string :schedule, null: false
    end
  end

  def down
    drop_table :budgets
  end
end
