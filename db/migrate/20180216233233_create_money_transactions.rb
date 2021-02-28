class CreateMoneyTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :money_transactions do |t|
      t.monetize :amount, currency: { present: false }
      t.references :installment
      t.references :person
      t.string :description
      t.boolean :done
      t.string :category #'installment', 'inscription', 'general'

      t.timestamps
    end
  end
end
