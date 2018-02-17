class CreateKlassesPackages < ActiveRecord::Migration[5.1]
  def change
    create_table :klasses_packages, id: false do |t|
      t.belongs_to :klass, index: true
      t.intebelongs_toger :package, index: true
    end
  end
end
