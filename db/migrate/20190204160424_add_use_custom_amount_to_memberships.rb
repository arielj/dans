class AddUseCustomAmountToMemberships < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :use_custom_amount, :boolean, default: false
  end
end
