# typed: true
# frozen_string_literal: true

class OldRoom < OldRecord
  self.table_name = :rooms

  has_many :schedules, class_name: 'OldSchedule', foreign_key: 'room_id'

  def to_new
    Room.create name: name, id: id
  end
end
