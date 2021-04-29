class AddUseManualDiscountForMemberships < ActiveRecord::Migration[6.1]
  def change
    add_column :memberships, :use_manual_discount, :boolean, default: false, comment: 'Indicates if the membership was added with a custom discount value'
    add_column :memberships, :manual_discount, :integer, default: '', comment: 'The % for the manually added discount'
  end
end
