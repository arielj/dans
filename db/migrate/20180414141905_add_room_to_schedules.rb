# typed: true
class AddRoomToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :room, :string, default: ''
  end
end
