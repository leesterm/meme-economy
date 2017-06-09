class AddPriceToUserHoldings < ActiveRecord::Migration
  def change
    add_column :user_holdings, :price, :float
  end
end
