# typed: true
class CreateDebts < ActiveRecord::Migration[5.2]
  def change
    create_table :debts do |t|
      t.references :person
      t.monetize :amount, currency: { present: false }
      t.integer :status, default: 0 #0 unpaid, 1 paid, 2 paid_with_recharge
      t.string :description

      t.timestamps
    end
  end
end
