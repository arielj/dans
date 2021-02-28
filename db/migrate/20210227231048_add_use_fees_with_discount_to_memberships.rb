class AddUseFeesWithDiscountToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :use_fees_with_discount, :boolean, default: false, comment: 'Use alternative fee with discount'
  end
end
