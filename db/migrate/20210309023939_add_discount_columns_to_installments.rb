class AddDiscountColumnsToInstallments < ActiveRecord::Migration[6.1]
  def change
    add_column :installments, :amount_with_discount_cents, :integer, default: 0, comment: 'Amount to pay with discount'
    add_column :installments, :use_amount_with_discount, :boolean, default: false, comment: 'Indicates if this installment was paid with a discount'
  end
end
