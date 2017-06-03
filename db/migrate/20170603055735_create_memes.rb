class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :name
      t.text :description
      t.string :img

      t.timestamps null: false
    end
  end
end
