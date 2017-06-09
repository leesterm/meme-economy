class ChangePriceToBuyPriceInUserPortfolio < ActiveRecord::Migration
  def change
    rename_column :user_holdings, :price, :buy_price
  end
end
