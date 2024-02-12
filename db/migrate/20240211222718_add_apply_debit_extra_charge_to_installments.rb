class AddApplyDebitExtraChargeToInstallments < ActiveRecord::Migration[6.1]
  def change
    add_column :installments, :apply_extra_debit_charge, :boolean, default: false, comment: 'Indicates if this installment was paid with debit'
  end
end
