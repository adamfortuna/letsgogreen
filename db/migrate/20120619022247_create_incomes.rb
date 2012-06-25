class CreateIncomes < ActiveRecord::Migration
    def up
    create_table :incomes do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.string :from, null: false
      t.decimal :amount, null: false
      t.date :date, null: false
      t.text :description
    end
  end

  def down
    drop_table :incomes
  end
end
