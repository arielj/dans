class Installment < ApplicationRecord
  belongs_to :membership
  has_one :person, through: :membership
  has_many :payments, class_name: 'MoneyTransaction'

  enum status: [:waiting, :paid, :paid_with_interests]

  monetize :amount_cents

  validates :month, inclusion: 0..11
  validates :year, presence: true

  def amount_paid
    payments.map(:amount).sum
  end

  def paid?
    !waiting?
  end

  def date(day = nil)
    day ||= 1
    Date.parse(year, month, day)
  end

  def get_recharge(ignore_recharge = false, ignore_month_recharge = false)
    after_day = Setting.get(:recharge_after_day, nil)
    recharge_value = Setting.get(:recharge_value, nil)
    month_recharge_value = Setting.get(:month_recharge_value, nil)

    recharge = 0

    bm = Date.today.beginning_of_month

    unless paid?
      rv = if month_recharge_value and created_at < beginning_of_month and !ignore_month_recharge
             month_recharge_value
           elsif recharge_value and today > date(after_day) and !ignore_recharge
             recharge_value
           end

      if rv
        if rv =~ /\A\d+%\z/
          amount*(rv[0:-1].to_i)/100
        elsif rv =~ /\A\d+\z/
          rv.to_i
        end
      end
    end
  end

  def total(ignore_recharge = None, ignore_month_recharge = None)
    amount+get_recharge(ignore_recharge, ignore_month_recharge)
  end

  def to_pay(ignore_recharge = None, ignore_month_recharge = None)
    total(ignore_recharge, ignore_month_recharge)-paid
  end
end
