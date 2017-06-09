class AddActionToTransactionLogs < ActiveRecord::Migration
  def change
    add_column :transaction_logs, :action, :string 
  end
end
