class AddVotesToMeme < ActiveRecord::Migration
  def change
    add_column :memes, :up, :integer
    add_column :memes, :down, :integer
  end
end
