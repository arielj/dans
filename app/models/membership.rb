class Membership < ApplicationRecord
  monetize :amount_cents

  belongs_to :person
  belongs_to :package, optional: true

  has_and_belongs_to_many :schedules
  has_many :klasses, through: :schedules
  has_many :installments

  enum status: [:inactive, :active]

  validates :person, presence: true

  after_create :create_installments, unless: :skip_installments

  attr_accessor :skip_installments

  def package=(p)
    self[:package_id] = p.id
    self.schedules = p.schedules
  end

  def to_label
    y = created_at.year
    y = package.name.gsub(/\AClases (\d{4}) .*/, '\1') if package and package.name =~ /\AClases \d{4} /
    "#{y} - (#{klasses.pluck(:name).uniq.join(', ')})"
  end

private
  def create_installments
    (0..11).each do |m|
      installments.create year: Date.today.year, month: m, amount: amount
    end
  end
end
