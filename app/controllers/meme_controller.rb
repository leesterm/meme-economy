class MemeController < ApplicationController
  def index
    @memes = Meme.all
  end

  def show
    @meme = Meme.find(params[:id])
    @meme_price = MemePrice.where(:meme_id => params[:id])
    @prices = Array.new();
    @meme_price.each do |p|
      @prices.push([p.closing_date,p.price]);
    end
  end

  def buy
    # buy
    buy_amt = params[:buy_amt]
    redirect_to meme_index_path
  end

  def sell
    # sell
    redirect_to meme_index_path
  end
  
  def upvote
    @meme = Meme.find(params[:id])
    @meme.upvote()
    redirect_to :back
  end

  def downvote
    @meme = Meme.find(params[:id])
    @meme.downvote()
    redirect_to :back
  end
end
