class MemeController < ApplicationController
  before_action :authenticate_user!, only: [:buy, :sell, :upvote, :downvote]
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
    @upvote = Vote.exists?(user_id: current_user.id, meme_id: params[:id], up: true)
    @downvote = Vote.exists?(user_id: current_user.id, meme_id: params[:id], up: false)
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
    if !voted?(true)
      @meme = Meme.find(params[:id])
      @vote = Vote.create(user_id: current_user.id, meme_id: params[:id], up: true)
      @meme.upvote()
    end
    redirect_to :back
  end

  def downvote
    if !voted?(false)
      @meme = Meme.find(params[:id])
      @vote = Vote.create(user_id: current_user.id, meme_id: params[:id], up: false)
      @meme.downvote()
    end
    redirect_to :back
  end

  private
    def voted?(v)
      @vote = Vote.find_by(user_id: current_user.id, meme_id: params[:id])
      if @vote
        if @vote.up == v
          return true
        else
          @vote.destroy
        end
      end
      return false
    end

end
