# typed: true
class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :lastname
      t.string :dni, limit: 10
      t.string :cellphone
      t.string :alt_phone
      t.date :birthday
      t.string :address
      t.boolean :female, default: true
      t.text :email
      t.boolean :is_teacher, default: false
      t.text :comments
      t.string :facebook_id
      t.integer :age
      t.integer :status, default: 1 #0 inactive, 1 active
      t.integer :family_group_id
      t.string :group, default: ''

      t.timestamps
    end
  end
end
