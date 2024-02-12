# frozen_string_literal: true

class Installment < ApplicationRecord
  include Payable
  monetize :amount_with_discount_cents

  belongs_to :membership
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
    recharge_day = Setting.fetch(:recharge_after_day, nil)
    if recharge_day
      d = DateTime.current.day <= recharge_day.to_i ? 1.month.ago : DateTime.current.to_date

      where('year < :y OR (year = :y AND month < :m)', y: d.year, m: d.month)
    else
      none
    end
  }

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

  def get_month_recharge(with_discount: false)
    return 0 if paid?

    month_recharge_value = Setting.fetch(:month_recharge_value, nil)

    return 0 if month_recharge_value.nil?
    return 0 unless date < DateTime.current.beginning_of_month.to_date

    _calculate_recharge(month_recharge_value, with_discount: with_discount)
  end

  def get_first_recharge(with_discount: false)
    return 0 if paid?

    after_day = Setting.fetch(:recharge_after_day, nil)
    recharge_value = Setting.fetch(:recharge_value, nil)

    return 0 if after_day.nil? || recharge_value.nil?
    return 0 unless DateTime.current.to_date > date(after_day)

    _calculate_recharge(recharge_value, with_discount: with_discount)
  end

  def get_second_recharge(with_discount: false)
    return 0 if paid?

    after_day = Setting.fetch(:second_recharge_after_day, nil)
    recharge_value = Setting.fetch(:second_recharge_value, nil)

    return 0 if after_day.nil? || recharge_value.nil?
    return 0 unless DateTime.current.to_date > date(after_day)

    _calculate_recharge(recharge_value, with_discount: with_discount)
  end

  def _calculate_recharge(rval, with_discount: false)
    aux = with_discount ? amount_with_discount : amount

    case rval
    when /\A\d+%\z/ then aux * rval[0..-1].to_i / 100
    when /\A\d+\z/ then rval.to_i
    else 0
    end
  end

  def get_recharge(ignore: false, with_discount: false)
    r1 = get_first_recharge(with_discount: with_discount)
    r2 = get_second_recharge(with_discount: with_discount)
    r3 = get_month_recharge(with_discount: with_discount)

    case ignore
    when :first, :all, 'first', 'all' then 0
    when :second, 'second' then r1
    when :month, 'month' then r2.positive? ? r2 : r1
    else
      if r3.positive?
        r3
      elsif r2.positive?
        r2
      else
        r1
      end
    end
  end

  def total(ignore_recharge: false, with_discount: false)
    aux = with_discount ? amount_with_discount : amount
    aux + get_recharge(ignore: ignore_recharge, with_discount: with_discount)
  end

  def to_pay(ignore_recharge: false, with_discount: false)
    return 0 if paid? || paid_with_interests?

    total(ignore_recharge: ignore_recharge, with_discount: with_discount) - amount_paid
  end

  def create_payment(attrs, ignore_recharge: false, with_discount: false)
    payment = MoneyTransaction.new attrs
    payment.person = person
    payment.done = false
    rest = to_pay(ignore_recharge: ignore_recharge, with_discount: with_discount)
    if payment.amount > rest && !next_installment
      payment.errors.add(:base, :amount_too_high)
    else
      if payment.amount > rest
        extra = payment.amount - rest
        payment.amount = rest
        next_installment.create_payment({amount: extra}, ignore_recharge: ignore_recharge, with_discount: with_discount)
      end
  
      payments << payment
      if payment.save && payment.amount == rest
        if amount_paid == amount_with_discount
          paid_with_debit!
        elsif amount_paid > amount
          paid_with_interests!
        else
          paid!
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
