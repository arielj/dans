class AddAmountToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_money :memberships, :amount, currency: { present: false }
  end
end
