class AddVolumeToMemes < ActiveRecord::Migration
  def change
    add_column :memes, :volume, :integer
  end
end
