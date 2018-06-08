class CreateKlassesPackages < ActiveRecord::Migration[5.1]
  def change
    create_table :klasses_packages, id: false do |t|
      t.references :klass, index: true
      t.references :package, index: true
    end
  end
end
