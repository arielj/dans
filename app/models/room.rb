class Room < ApplicationRecord
  has_many :schedules
  has_many :klasses, through: :schedules

  validates :name, uniqueness: true, presence: true

  def schedules_for_day(day)
    schedules.where(day: day).joins(:klass).where(Klass.arel_table[:status].eq(:active)).to_a
  end
end
