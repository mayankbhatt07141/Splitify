class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.float :amount
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :group, null: false, foreign_key: true
      t.timestamps
    end
  end
end
