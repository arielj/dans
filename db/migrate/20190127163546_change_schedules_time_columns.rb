# typed: false
class ChangeSchedulesTimeColumns < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :schedules, :from_time
    remove_column :schedules, :to_time
    add_column :schedules, :from_time, :integer
    add_column :schedules, :to_time, :integer
  end

  def self.down
    remove_column :schedules, :from_time
    remove_column :schedules, :to_time
    add_column :schedules, :from_time, :string, limit: 5
    add_column :schedules, :to_time, :string, limit: 5
  end
end
