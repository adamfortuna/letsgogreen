class CreateCategories < ActiveRecord::Migration
  def up
    create_table "categories" do |t|
      t.timestamps
      t.string :type
      t.integer :user_id, null: false
      t.string :title,  null: false
      t.string :alias
      t.decimal :amount, null: false
      t.text :description
      t.boolean :variable_amount, default: false, null: false
      t.string :schedule
      t.boolean :after_tax, default: true, null: false
    end

    execute <<-SQL
      INSERT INTO categories (created_at, updated_at, user_id, type, title, alias, amount, description, variable_amount, schedule) SELECT created_at, updated_at, user_id, 'Bill', payee, title, amount, description, variable_amount, schedule FROM bills
    SQL

    execute <<-SQL
      INSERT INTO categories (type, created_at, updated_at, user_id,
        title, amount, description, variable_amount, schedule)
      SELECT 'Budget', created_at, updated_at, user_id, title,
        amount, description, true, schedule
        FROM budgets
    SQL

    execute <<-SQL
      INSERT INTO categories (type, created_at, updated_at, user_id,
        title, amount, description, variable_amount, schedule)
      SELECT 'Income', created_at, updated_at, user_id, name,
        amount, description, true, schedule
        FROM incomes
    SQL

    execute <<-SQL
      INSERT INTO categories (type, created_at, updated_at, user_id,
        title, amount, description, variable_amount, schedule,
        after_tax)
      SELECT 'Saving', created_at, updated_at, user_id, title,
        amount, description, variable_amount, schedule, NOT from_before_tax_income
        FROM savings
    SQL
  end

  def down
    drop_table :categories
  end
end
