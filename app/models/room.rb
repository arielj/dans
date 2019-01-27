class Room < ApplicationRecord
  has_many :schedules
  has_many :klasses, through: :schedules

  def schedules_for_day(day)
    schedules.where(day: day).to_a
  end
end
