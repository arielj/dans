# typed: false
# frozen_string_literal: true

class Membership < ApplicationRecord
  has_paper_trail

  monetize :amount_cents, numericality: false

  belongs_to :person
  belongs_to :package, optional: true

  has_and_belongs_to_many :schedules
  has_many :klasses, through: :schedules
  has_many :installments, dependent: :destroy

  enum status: %i[inactive active]

  validates :person, presence: true

  after_create :create_installments_on_create, unless: :skip_installments
  after_update :update_installments_on_update, if: :update_unpaid_installments

  attr_accessor :skip_installments, :create_installments_from, :create_installments_to, :update_unpaid_installments

  def package=(pkg)
    self[:package_id] = pkg.id
    self.schedules = pkg.schedules
  end

  def to_label
    y = created_at.year
    pkg_name = package&.name || ''
    y = pkg_name.gsub(/\AClases (\d{4}) .*/, '\1') if pkg_name =~ /\AClases \d{4} /
    "#{y} - (#{klasses.pluck(:name).uniq.join(', ')})"
  end

  def amount
    if use_custom_amount
      Money.new(self[:amount_cents])
    else
      amounts[:total]
    end
  end

  def amounts
    person.new_membership_amount_calculator(schedule_ids, use_non_regular_fee)
  end

  def create_installments(from, to, year, amount)
    from = Installment.month_num(from) - 1
    to = Installment.month_num(to) - 1

    (from..to).each do |m|
      installments.create year: year, month: m, amount: amount
    end
  end

  private

  def create_installments_on_create
    from = @create_installments_from || :january
    to = @create_installments_to || :december
    create_installments(from, to, DateTime.current.year, amount)
  end

  def update_installments_on_update
    installments.waiting.each do |ins|
      ins.amount = amount
      ins.save(validate: false)
    end
  end
end
