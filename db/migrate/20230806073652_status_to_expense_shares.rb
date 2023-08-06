class StatusToExpenseShares < ActiveRecord::Migration[7.0]
  def change
    add_column :expense_shares, :status, :integer, default: 0
  end
end
