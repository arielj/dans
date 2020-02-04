class AddUseNonRegularFeeToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :use_non_regular_fee, :boolean
  end
end
