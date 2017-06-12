class HomeController < ApplicationController
  def index
     @memes = Meme.order(up: :desc).limit(4)
  end

  def about

  end
end
