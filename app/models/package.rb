# frozen_string_literal: true

class Package < ApplicationRecord
  has_and_belongs_to_many :schedules
  has_many :klasses, -> { distinct }, through: :schedules
  belongs_to :person, optional: true
  has_many :memberships, inverse_of: :package
  has_many :students, through: :memberships, source: :person

  monetize :fee_cents
  monetize :alt_fee_cents

  scope :not_personal, -> { where(person_id: 0) }
  scope :search, ->(q) { where('name LIKE ?', "%#{q}%") }
end
