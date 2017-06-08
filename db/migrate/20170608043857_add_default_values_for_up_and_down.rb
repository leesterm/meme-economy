class AddDefaultValuesForUpAndDown < ActiveRecord::Migration
  def change
      change_column_default(:memes, :up, 0)
      change_column_default(:memes, :down, 0)
  end
end
