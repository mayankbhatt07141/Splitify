class PaidByToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :paid_by, :integer
  end
end
