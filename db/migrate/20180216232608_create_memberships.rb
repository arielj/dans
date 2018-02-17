class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.references :person
      t.text :info
      t.belongs_to :package
      t.integer :status, default: 1 #0 inactive, 1 active

      t.timestamps
    end
  end
end
