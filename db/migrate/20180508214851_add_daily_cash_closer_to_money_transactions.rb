# typed: true
class AddDailyCashCloserToMoneyTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :money_transactions, :daily_cash_closer, :boolean, default: false
  end
end
