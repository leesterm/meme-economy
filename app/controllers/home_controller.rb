class HomeController < ApplicationController
  def index
	@memes = Meme.all
  end
  def about
  end
end
