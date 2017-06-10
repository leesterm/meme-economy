class HomeController < ApplicationController
  def index
	@memes = Meme.all
  @memes.each do |p|
    puts p.previous_price ? "---------------Previous Price "+p.previous_price.price.to_s : "-------no price" 
  end
  end

  def about
  end
end
