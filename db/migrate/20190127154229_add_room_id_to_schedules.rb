# typed: false
class AddRoomIdToSchedules < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :schedules, :room
    add_reference :schedules, :room
  end

  def self.down
    remove_reference :schedules, :room
    add_column :schedules, :room, :string, defaul: ''
  end
end
