class AddTitleToBills < ActiveRecord::Migration
  def change
    add_column :bills, :title, :string
    add_column :bills, :variable_amount, :boolean
  end
end
