class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.where(user_id: current_user.id)
  end

  def create
  end
end
