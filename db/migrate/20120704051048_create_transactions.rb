class CreateTransactions < ActiveRecord::Migration
  def up
    create_table "transactions" do |t|
      t.timestamps
      t.string :type
      t.integer :category_id
      t.integer :user_id, null: false
      t.string :title,  null: false
      t.decimal :amount, null: false
      t.date :date, null: false
      t.text :description
      t.boolean :after_tax, default: true, null: false
      t.boolean :confirmed, default: true, null: false
    end

    execute <<-SQL
      INSERT INTO transactions (created_at, updated_at, user_id, type, category_id, title, amount, date,
        description)
      SELECT created_at, updated_at, user_id, 'Debit', accountable_id, payee, amount, date, description 
        FROM expenses
    SQL
  end

  def down
    drop_table :transactions
  end
end
