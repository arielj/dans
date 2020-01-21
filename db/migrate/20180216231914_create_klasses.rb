# typed: true
class CreateKlasses < ActiveRecord::Migration[5.1]
  def change
    create_table :klasses do |t|
      t.string :name
      t.monetize :fixed_fee, currency: { present: false }
      t.references :teacher
      t.integer :status, default: 1 #0 inactive, 1 active

      t.timestamps
    end
  end
end
