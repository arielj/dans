# frozen_string_literal: true

class Installment < ApplicationRecord
  include Payable
  monetize :amount_with_discount_cents

  belongs_to :membership, required: true
  has_one :person, through: :membership
  has_many :membership_klasses, class_name: "Klass", through: :membership, source: :klasses
  has_and_belongs_to_many :klasses

  def get_klasses
    klasses.present? ? klasses : membership_klasses
  end

  enum month: %i[january february march april may june july august september october november december]

  validates :year, :month, presence: true
  validates :membership_id, uniqueness: { scope: %i[month year] }

  before_destroy :fix_payments

  scope :for_active_users, -> { references(:person).where(people: { status: :active }) }
  scope :with_recharge, lambda {
    d = DateTime.current.day <= FIRST_SURCHARGE_AFTER_DAY.to_i ? 1.month.ago : DateTime.current.to_date

    where('year < :y OR (year = :y AND month < :m)', y: d.year, m: d.month)
  }

  serialize :membership_amounts

  def self.months_for_select
    ds = I18n.t('date.month_names')
    [[ds[1], :january], [ds[2], :february], [ds[3], :march], [ds[4], :april],
     [ds[5], :may], [ds[6], :june], [ds[7], :july], [ds[8], :august],
     [ds[9], :september], [ds[10], :october], [ds[11], :november], [ds[12], :december]]
  end

  def month_name
    I18n.t('date.month_names')[month_num]
  end

  def month_num
    self.class.month_num(month)
  end

  def self.month_num(month_sym)
    Installment.months[month_sym] + 1
  end

  def self.month_sym(month_num)
    Installment.months.select { |_k, v| v == month_num }.keys.first
  end

  def date(day = nil)
    day ||= 1
    Date.new(year, month_num, day.to_i)
  end

  def get_first_recharge
    return 0 if !waiting?
    return 0 unless DateTime.current.to_date > date(FIRST_SURCHARGE_AFTER_DAY)

    _calculate_recharge(FIRST_SURCHARGE_PERCENT)
  end

  def get_second_recharge
    return 0 if !waiting?
    return 0 unless DateTime.current.to_date > date(SECOND_SURCHARGE_AFTER_DAY)

    _calculate_recharge(SECOND_SURCHARGE_PERCENT)
  end

  def _calculate_recharge(rval)
    amount_with_discount * rval / 100
  end

  def get_recharge(ignore: false)
    r1 = get_first_recharge
    r2 = get_second_recharge

    case ignore
    when :first, :all, 'first', 'all' then 0
    when :second, 'second' then r1
    else
      if r2.positive?
        r2
      else
        r1
      end
    end
  end

  def total(ignore_recharge: false, add_debit_extra: false)
    subtotal = amount_with_discount + get_recharge(ignore: ignore_recharge)
    add_debit_extra ? subtotal + DEBIT_EXTRA : subtotal
  end

  def to_pay(ignore_recharge: false, add_debit_extra: false)
    return 0 if !waiting?

    total(ignore_recharge: ignore_recharge, add_debit_extra: add_debit_extra) - amount_paid
  end

  # attrs: { amount: number, description: string }
  def create_payment(attrs, ignore_recharge: false, add_debit_extra: false)
    payment = MoneyTransaction.new attrs
    payment.person = person
    payment.done = false
    rest = to_pay(ignore_recharge: ignore_recharge, add_debit_extra: add_debit_extra)
    if payment.amount > rest && !next_installment
      payment.errors.add(:base, :amount_too_high)
    else
      extra = Money.new(0)
      if payment.amount > rest
        extra = payment.amount - rest
        payment.amount = rest
      end
  
      payments << payment
      if payment.save && payment.amount == rest
        if to_pay(ignore_recharge: ignore_recharge, add_debit_extra: add_debit_extra) == Money.new(0)
          if amount_paid == total(ignore_recharge: :all)
            paid!
          elsif amount_paid == total(ignore_recharge: false) || amount_paid == total(ignore_recharge: :second)
            paid_with_interests!
          elsif add_debit_extra && amount_paid == total(ignore_recharge: :all, add_debit_extra: add_debit_extra)
            paid_with_debit!
          elsif add_debit_extra && amount_paid == total(ignore_recharge: false, add_debit_extra: add_debit_extra) || amount_paid == total(ignore_recharge: :second, add_debit_extra: add_debit_extra)
            paid_with_interests_and_debit!
          end
        end

        if (extra > Money.new(0))
          next_installment.create_payment({amount: extra}, ignore_recharge: ignore_recharge)
        end
      end
    end
    payment
  end

  def update_amount!(new_amount)
    new_amount = Money.new(new_amount.gsub(',', '').to_i)
    if amount_paid >= new_amount
      if waiting?
        self.amount = amount_paid
        self.status = :paid
      end
    else
      self.amount = new_amount
      self.status = :waiting
    end

    save
  end

  def next_installment
    person.installments.where(year: year).where("month >= ?", month_num).order(month: :asc).first
  end

  private

  def fix_payments
    payments.each do |pay|
      pay.payable = nil
      pay.description ||= ''
      pay.description&.concat(" (Cuota #{month_name} - #{year})")
      pay.description&.strip!
      pay.save(validate: false)
    end
  end
end
