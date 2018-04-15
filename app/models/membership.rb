class Membership < ApplicationRecord
  belongs_to :person
  belongs_to :package, optional: true

  has_and_belongs_to_many :schedules
  has_many :klasses, through: :schedules
  has_many :installments

  validates :person, :schedules, presence: true

  def package=(p)
    self[:package] = p
    self.schedules = p.schedules
  end

end
