class MemeController < ApplicationController
  before_action :authenticate_user!, only: [:create, :buy, :sell, :upvote, :downvote]
  def index
    @memes = Meme.all
  end

  def new
    @meme = Meme.new()
  end

  def create
    meme = Meme.new(meme_params)
    meme.up = 0
    meme.down = 0
    meme.volume = 1000000
    meme.user_id = current_user.id
    meme.save
    meme.upvote
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
      redirect_to user_portfolios_path(current_user.id)
    else
      flash[:notice] = 'Failed to buy'
      @alert = true
      redirect_to meme_path
    end
  end

  def sell
    meme = Meme.find(params[:id])
    sell_amt = params[:sell_amt].to_f()
    if meme.sell(sell_amt,current_user)
        redirect_to user_portfolios_path(current_user.id)
    else
      flash[:notice] = 'Failed to sell'
      @alert = true
      redirect_to meme_path
    end
  end

  def upvote
    vote_status = voted?
    meme = Meme.find(params[:id])
    if vote_status[0] # There exists a users vote for this meme already
      if vote_status[1].up == true # The existing vote was an upvote
        meme.downvote
        vote_status[1].destroy
      else # The existing vote was a downvote
        meme.up += 2
        vote_status[1].up = true
        meme.save
        vote_status[1].save
      end
    else #There does not exist a users vote for this meme, create it
      vote = Vote.create(user_id: current_user.id, meme_id: params[:id], up: true)
      meme.upvote
    end
    redirect_to :back
  end

  def downvote
    vote_status = voted?
    meme = Meme.find(params[:id])
    if vote_status[0] # There exists a users vote for this meme already
      if vote_status[1].up == false # The existing vote was an downnvote
        meme.upvote
        vote_status[1].destroy
      else # The existing vote was a upvote
        meme.down += 2
        vote_status[1].up = false
        meme.save
        vote_status[1].save
      end
    else #There does not exist a users vote for this meme, create it
      vote = Vote.create(user_id: current_user.id, meme_id: params[:id], up: false)
      meme.downvote
    end
    redirect_to :back
  end

  private
    def voted?
      vote = Vote.find_by(user_id: current_user.id, meme_id: params[:id])
      if vote
        return [true, vote]
      else
        return [false, nil]
      end
    end

    def meme_params()
      params.require(:meme).permit(:name, :description, :meme_img)
    end

end
