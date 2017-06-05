class MemePrice < ActiveRecord::Base
  belongs_to :Meme
  def add_closing_price(meme_id,price,date)
    @meme = Meme.find(meme_id)
    if meme
      @meme_price = MemePrice.new(:meme => @meme,:price => price, :date => date)
      @meme_price.save
    end
  end
end
