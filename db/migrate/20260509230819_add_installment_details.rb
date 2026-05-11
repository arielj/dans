class AddInstallmentDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :installments, :membership_amounts, :text, comment: "Membership amounts details"
  end
end
