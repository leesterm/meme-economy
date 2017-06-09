class UserHoldingsController < ApplicationController
  def index
    @user_holdings = UserHolding.where(user_id: current_user.id)
  end

  def create
  end
end
