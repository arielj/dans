# frozen_string_literal: true

class Membership < ApplicationRecord
  # if membership klasses changes after this day number, update installments starting next month
  # else, update installments starting current month
  INSTALLMENTS_UPDATE_KLASSES_DAY = 25

  has_paper_trail

  monetize :amount_cents, numericality: false

  belongs_to :person
  belongs_to :package, optional: true

  has_and_belongs_to_many :schedules
  has_many :klasses, through: :schedules
  has_many :installments, dependent: :destroy

  enum status: %i[inactive active]

  validates :person, presence: true

  after_save :create_installments_on_save, unless: :skip_installments
  after_update :update_installments_on_update

  attr_accessor :skip_installments, :create_installments_from, :create_installments_to,
                :update_unpaid_installments, :update_paid_installments

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
    person.new_membership_amount_calculator(schedule_ids, use_non_regular_fee, use_fees_with_discount: use_fees_with_discount)
  end

  def create_installments(from, to, year, amount)
    from = Installment.month_num(from) - 1
    to = Installment.month_num(to) - 1

    (from..to).each do |m|
      next if installments.where(year: year, month: m).any?

      installments.create year: year, month: m, amount: amount, klasses: klasses
    end
  end

  def installments_for_month(month)
    installments.where(month: month)
  end

  private

  def create_installments_on_save
    from = @create_installments_from || :january
    to = @create_installments_to || :december
    create_installments(from, to, DateTime.current.year, amount)
  end

  def update_installments_on_update
    months_range = Installment.months[@create_installments_from]..Installment.months[@create_installments_to]

    installments.includes(:klasses).each do |ins|
      date_comp = DateTime.new(DateTime.current.year, ins.month_before_type_cast + 1, 1) + INSTALLMENTS_UPDATE_KLASSES_DAY.days

      # if current day is more than 25, change from next month and on
      # if current day is less than 25, change from current month and on
      if ins.klasses != klasses.uniq && DateTime.current < date_comp
        ins.klasses = klasses.uniq
      end

      next unless months_range.include?(ins.month_before_type_cast)
      next if ins.waiting? && !update_unpaid_installments
      next if !ins.waiting? && !update_paid_installments

      aux = amount.is_a?(String) ? Money.new(amount.gsub(',', '').to_i) : amount

      if ins.amount_paid > aux
        ins.status = :paid if ins.waiting?
      else
        ins.amount = amount
        ins.status = :waiting
      end

      ins.save(validate: false)
    end
  end
end
