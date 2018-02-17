class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.references :klass
      t.string :from_time, limit: 5
      t.string :to_time, limit: 5
      t.integer :day, limit: 6

      t.timestamps
    end
  end
end
