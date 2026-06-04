class AddPaymentInfoToMoneyTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :money_transactions, :payment_method, :integer
    add_column :money_transactions, :first_surcharge_ignored, :boolean
    add_column :money_transactions, :second_surcharge_ignored, :boolean
    add_column :money_transactions, :debit_extra_ignored, :boolean
  end
end
