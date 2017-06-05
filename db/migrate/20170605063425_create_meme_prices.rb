class CreateMemePrices < ActiveRecord::Migration
  def change
    create_table :meme_prices do |t|
      t.references :meme, index: true, foreign_key: true
      t.float :price
      t.date :closing_date

      t.timestamps null: false
    end
  end
end
