class ChangeImgToMemeImg < ActiveRecord::Migration
  def change
    rename_column :memes, :img, :meme_img
  end
end
