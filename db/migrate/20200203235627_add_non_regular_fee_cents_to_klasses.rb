class AddNonRegularFeeCentsToKlasses < ActiveRecord::Migration[6.0]
  def change
    add_column :klasses, :non_regular_fee_cents, :integer
  end
end
