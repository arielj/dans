class CreateKlassesMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :klasses_memberships, id: false do |t|
      t.belongs_to :klass, index: true
      t.belongs_to :membership, index: true
    end
  end
end
