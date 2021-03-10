class AddAmountWithDiscountToMemberships < ActiveRecord::Migration[6.1]
  def change
    add_column :memberships, :amount_with_discount_cents, :integer, default: 0, comment: 'Price of the membership using discount values'
  end
end
