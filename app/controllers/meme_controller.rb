class MemeController < ApplicationController
  before_action :authenticate_user!, only: [:create, :buy, :sell, :upvote, :downvote]
  def index
    @memes = Meme.all
  end

  def new
    @meme = Meme.new()
  end

  def create
    puts meme_params
    puts meme_params
    puts meme_params
    @meme = Meme.new(meme_params)
    @meme.up = 1
    @meme.down = 0
    @meme.volume = 1000000
    @meme.user_id = current_user.id
    @meme.save
    redirect_to root_path
  end

  def show
    @meme = Meme.find(params[:id])
    @meme_price = MemePrice.where(:meme_id => params[:id])
    @prices = Array.new();
    @meme_price.each do |p|
      @prices.push([p.closing_date,p.price]);
    end
    if user_signed_in?
      @upvote = Vote.exists?(user_id: current_user.id, meme_id: params[:id], up: true)
      @downvote = Vote.exists?(user_id: current_user.id, meme_id: params[:id], up: false)
    end
  end

  def buy
    meme = Meme.find(params[:id])
    buy_amt = params[:buy_amt].to_f()
    if meme.buy(buy_amt,current_user)
      redirect_to user_userholdings_path(current_user.id)
    else
      flash[:notice] = 'Failed to buy'
      redirect_to meme_path
    end
  end

  def sell
    meme = Meme.find(params[:id])
    sell_amt = params[:sell_amt].to_f()
    if meme.sell(sell_amt,current_user)
        redirect_to user_userholdings_path(current_user.id)
    else
      flash[:notice] = 'Failed to sell'
      redirect_to meme_path
    end
  end

  def upvote
    if !voted?(true)
      meme = Meme.find(params[:id])
      vote = Vote.create(user_id: current_user.id, meme_id: params[:id], up: true)
      meme.upvote()
    end
    redirect_to :back
  end

  def downvote
    if !voted?(false)
      meme = Meme.find(params[:id])
      vote = Vote.create(user_id: current_user.id, meme_id: params[:id], up: false)
      meme.downvote()
    end
    redirect_to :back
  end

  private
    def voted?(v)
      vote = Vote.find_by(user_id: current_user.id, meme_id: params[:id])
      if vote
        if vote.up == v
          return true
        else
          vote.destroy
        end
      end
      return false
    end

    def meme_params()
      params.require(:meme).permit(:name, :description, :img)
    end

end
