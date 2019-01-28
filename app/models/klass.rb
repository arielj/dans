class Klass < ApplicationRecord
  monetize :fixed_fee_cents

  has_many :schedules, inverse_of: :klass, dependent: :destroy
  accepts_nested_attributes_for :schedules, reject_if: :all_blank, allow_destroy: true

  has_many :klasses_packages
  has_many :packages, through: :klasses_packages

  has_many :klasses_memberships
  has_many :memberships, through: :klasses_memberships

  validates :name, presence: true

  enum status: [:inactive, :active]

  def get_memberships
    memberships + packages.map(&:memberships).flatten
  end

  def students
    pids = get_memberships.map(&:person_id)
    Person.where(id: pids)
  end

  def toggle_active
    to = active? ? :inactive : :active
    update_column(:status, to)
  end
end
