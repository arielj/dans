class AppFeeAndAltFeeToPackages < ActiveRecord::Migration[5.2]
  def change
    add_money :packages, :fee, currency: { present: false }
    add_money :packages, :alt_fee, currency: { present: false }
  end
end
