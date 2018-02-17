class Membership < ApplicationRecord
  belongs_to :person

  belongs_to :package, optional: true
  has_many :klasses_memberships
  has_many :klasses, through: :klasses_memberships

  has_many :installments

  def get_klasses
    package ? package.klasses : klasses
  end
end
