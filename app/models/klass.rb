class Klass < ApplicationRecord
  monetize :fixed_fee_cents

  has_many :schedules, inverse_of: :klass, dependent: :destroy
  accepts_nested_attributes_for :schedules, reject_if: :all_blank, allow_destroy: true

  has_many :klasses_packages
  has_many :packages, through: :klasses_packages

  has_many :klasses_memberships
  has_many :memberships, through: :klasses_memberships

  validates :name, presence: true

  def get_memberships
    m = memberships
    packages.each do |p|
      m += p.memberships
    end
    m
  end

  def students
    pids = get_memberships.map(&:person_id)
    Person.where(id: pids)
  end

  def toggle_active
    self.status = self.status == 1 ? 0 : 1
    save
  end

  def active?
    status == 1
  end
end
