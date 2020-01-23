# typed: false
# frozen_string_literal: true

class Membership < ApplicationRecord
  monetize :amount_cents, numericality: false

  belongs_to :person
  belongs_to :package, optional: true

  has_and_belongs_to_many :schedules
  has_many :klasses, through: :schedules
  has_many :installments

  enum status: %i[inactive active]

  validates :person, presence: true

  after_create :create_installments, unless: :skip_installments

  attr_accessor :skip_installments, :create_installments_from, :create_installments_to

  def package=(pkg)
    self[:package_id] = pkg.id
    self.schedules = pkg.schedules
  end

  def to_label
    y = created_at.year
    y = package.name.gsub(/\AClases (\d{4}) .*/, '\1') if package && package.name =~ /\AClases \d{4} /
    "#{y} - (#{klasses.pluck(:name).uniq.join(', ')})"
  end

  def amount
    if use_custom_amount
      self[:amount]
    else
      person.new_membership_amount_calculator(schedule_ids)[:total]
    end
  end

  private

  def create_installments
    from = @create_installments_from
    from = from ? Installment.month_num(from) - 1 : 0

    to = @create_installments_to
    to = to ? Installment.month_num(to) - 1 : 11

    (from..to).each do |m|
      installments.create year: Date.today.year, month: m, amount: amount
    end
  end
end
