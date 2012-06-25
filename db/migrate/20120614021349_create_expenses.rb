class CreateExpenses < ActiveRecord::Migration
  def up
    create_table :expenses do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.string :payee, null: false
      t.decimal :amount, null: false
      t.date :date, null: false
      t.text :description
    end
  end

  def down
    drop_table :expenses
  end
end
