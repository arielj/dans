class AddPayableReferenceToMoneyTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :money_transactions, :payable, polymorphic: true
  end
end
