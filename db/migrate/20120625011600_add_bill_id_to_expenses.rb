class AddBillIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :bill_id, :integer
  end
end
