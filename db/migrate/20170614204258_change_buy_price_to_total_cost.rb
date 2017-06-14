class ChangeBuyPriceToTotalCost < ActiveRecord::Migration
  def change
    rename_column :portfolios, :buy_price, :total_cost
  end
end
