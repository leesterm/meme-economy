class AddNotNullToMemes < ActiveRecord::Migration
  def change
    change_column :memes, :name, :string, null: false
    change_column :memes, :img, :string, null: false
    change_column :memes, :description, :string, null: false
  end
end
