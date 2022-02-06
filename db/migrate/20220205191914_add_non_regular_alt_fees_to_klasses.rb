class AddNonRegularAltFeesToKlasses < ActiveRecord::Migration[6.1]
  def change
    add_column :klasses, :non_regular_alt_fee_cents, :integer, default: 0
    add_column :klasses, :non_regular_alt_fee_with_discount_cents, :integer, default: 0
  end
end
