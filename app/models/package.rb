class Package < ApplicationRecord
  has_many :klasses
  belongs_to :person, optional: true
  has_many :memberships, inverse_of: :package
end
