# typed: true
class CreateMembershipsSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships_schedules, id: false do |t|
      t.belongs_to :membership, index: true
      t.belongs_to :schedule, index: true
    end
  end
end
