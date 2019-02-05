class Package < ApplicationRecord
  has_and_belongs_to_many :klasses
  has_many :schedules, through: :klasses
  belongs_to :person, optional: true
  has_many :memberships, inverse_of: :package
  has_many :students, through: :memberships, source: :person

  monetize :fee_cents
  monetize :alt_fee_cents

end
