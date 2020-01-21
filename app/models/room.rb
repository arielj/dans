# typed: true
# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :schedules
  has_many :klasses, through: :schedules

  validates :name, uniqueness: { case_sensitive: false }, presence: true

  def schedules_for_day(day)
    schedules
      .where(day: day).includes(:klass).references(:klass)
      .where(Klass.arel_table[:status].eq(:active)).to_a
  end
end
