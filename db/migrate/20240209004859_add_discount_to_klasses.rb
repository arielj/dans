class AddDiscountToKlasses < ActiveRecord::Migration[6.1]
  def change
    add_column :klasses, :discount, :string, comment: "% value to use as a discount on the fee"
  end
end
