# typed: true
class CreatePackagesSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :packages_schedules do |t|
      t.references :package, index: true
      t.references :schedule, index: true
    end
  end
end
