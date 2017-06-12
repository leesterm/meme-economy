class RenameUserHoldingsToPortfolio < ActiveRecord::Migration
  def change
    rename_table :user_holdings, :portfolios
  end
end
