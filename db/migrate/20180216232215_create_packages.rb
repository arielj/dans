# typed: true
class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.references :person

      t.timestamps
    end
  end
end
