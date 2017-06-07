class CreateUserHoldings < ActiveRecord::Migration
  def change
    create_table :user_holdings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :meme, index: true, foreign_key: true
      t.integer :amt

      t.timestamps null: false
    end
  end
end
