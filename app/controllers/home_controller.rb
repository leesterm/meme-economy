class HomeController < ApplicationController
  def index
	@memes = Meme.all
  end
end
