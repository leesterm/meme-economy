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
end
