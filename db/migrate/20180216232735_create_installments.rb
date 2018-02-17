class CreateInstallments < ActiveRecord::Migration[5.1]
  def change
    create_table :installments do |t|
      t.integer :year
      t.integer :month
      t.references :membership
      t.monetize :amount, currency: { present: false }
      t.integer :status, default: 0 #0 unpaid, 1 paid, 2 paid_with_recharge
      t.decimal :hours, precision: 5, scale: 2

      t.timestamps
    end
  end
end
