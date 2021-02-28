class AddFeesWithDiscountToKlasses < ActiveRecord::Migration[6.0]
  def change
    add_column :klasses, :fixed_fee_with_discount_cents, :integer, default: 0
    add_column :klasses, :non_regular_fee_with_discount_cents, :integer, default: 0
  end
end
