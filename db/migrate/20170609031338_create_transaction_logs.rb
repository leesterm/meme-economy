class CreateTransactionLogs < ActiveRecord::Migration
  def change
    create_table :transaction_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :meme, index: true, foreign_key: true
      t.integer :amt
      t.float :price

      t.timestamps null: false
    end
  end
end
