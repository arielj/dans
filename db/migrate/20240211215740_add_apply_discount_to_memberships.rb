class AddApplyDiscountToMemberships < ActiveRecord::Migration[6.1]
  def change
    add_column :memberships, :apply_discounts, :boolean
  end
end
