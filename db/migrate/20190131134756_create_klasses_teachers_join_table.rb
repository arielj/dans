# typed: true
class CreateKlassesTeachersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :klasses_teachers, id: false do |t|
      t.references :klass, index: true
      t.references :teacher, index: true
    end
  end
end
