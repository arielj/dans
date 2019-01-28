class Membership < ApplicationRecord
  monetize :amount_cents

  belongs_to :person
  belongs_to :package, optional: true

  has_and_belongs_to_many :schedules
  has_many :klasses, through: :schedules
  has_many :installments

  validates :person, :schedules, presence: true

  after_create :create_installments

  def package=(p)
    self[:package] = p
    self.schedules = p.schedules
  end

  def to_label
    "#{created_at.year} - (#{klasses.pluck(:name).uniq.join(', ')})"
  end

private
  def create_installments
    (0..11).each do |m|
      installments.create year: Date.today.year, month: m, amount: amount
    end
  end
end
