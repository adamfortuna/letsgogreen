class CreateBills < ActiveRecord::Migration
  def up
    create_table :bills do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.string :payee, null: false
      t.decimal :amount, null: false
      t.date :date, null: false
      t.text :description
      t.string :schedule
    end
  end

  def down
    drop_table :bills
  end
end
