class CreateSavings < ActiveRecord::Migration
  def up
    create_table :savings do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.string :title, null: false
      t.decimal :amount, null: false
      t.text :description
      t.string :schedule
      t.boolean :variable_amount
    end
  end

  def down
    drop_table :savings
  end
end
