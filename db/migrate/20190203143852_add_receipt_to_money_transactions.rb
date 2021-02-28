class AddReceiptToMoneyTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :money_transactions, :receipt, :integer
  end
end
