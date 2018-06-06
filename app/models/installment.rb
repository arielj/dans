class Installment < ApplicationRecord
  belongs_to :membership
  has_one :person, through: :membership
  has_many :payments, class_name: 'MoneyTransaction'

  enum status: [:waiting, :paid, :paid_with_interests]

  enum month: [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]

  monetize :amount_cents

  validates :year, presence: true

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
    Installment.months[month]+1
  end

  def amount_paid
    payments.map(&:amount).sum
  end

  def paid?
    !waiting?
  end

  def date(day = nil)
    day ||= 1
    Date.new(year, month_num, day.to_i)
  end

  def get_month_recharge
    return 0 if paid?

    month_recharge_value = Setting.fetch(:month_recharge_value, nil)
    return 0 if month_recharge_value.nil?

    return 0 unless created_at < Date.today.beginning_of_month

    _calculate_recharge(month_recharge_value)
  end

  def get_first_recharge
    return 0 if paid?

    after_day = Setting.fetch(:recharge_after_day, nil)
    recharge_value = Setting.fetch(:recharge_value, nil)

    return 0 if after_day.nil? or recharge_value.nil?

    return 0 unless Date.today > date(after_day)

    _calculate_recharge(recharge_value)
  end

  def _calculate_recharge(rv)
    case rv
    when /\A\d+%\z/
      amount*(rv[0..-1].to_i)/100
    when /\A\d+\z/
      rv.to_i
    else
      0
    end
  end

  def get_recharge(ignore_recharge = false, ignore_month_recharge = false)
    r = get_month_recharge
    if r > 0 and !ignore_month_recharge
      r
    else
      r = get_first_recharge
      if r > 0 and !ignore_recharge
        r
      else
        0
      end
    end
  end

  def total(ignore_recharge = nil, ignore_month_recharge = nil)
    amount+get_recharge(ignore_recharge, ignore_month_recharge)
  end

  def to_pay(ignore_recharge = nil, ignore_month_recharge = nil)
    return 0 if paid?
    total(ignore_recharge, ignore_month_recharge)-amount_paid
  end

  def create_payment(attrs, ignore_recharge, ignore_month_recharge)
    payment = MoneyTransaction.new attrs
    rest = to_pay(ignore_recharge, ignore_month_recharge)
    if payment.amount > rest
      payment.errors.add(:base, :amount_too_high)
    else
      payments << payment
      if payment.save
        if payment.amount == rest
          if amount_paid > amount
            self.paid_with_interests!
          else
            self.paid!
          end
        end
      end
    end
    payment
  end
end
