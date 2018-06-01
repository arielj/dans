class Installment < ApplicationRecord
  belongs_to :membership
  has_one :person, through: :membership
  has_many :payments, class_name: 'MoneyTransaction'

  enum status: [:waiting, :paid, :paid_with_interests]

  enum month: [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]

  monetize :amount_cents

  validates :month, inclusion: 0..11
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
    payments.map(:amount).sum
  end

  def paid?
    !waiting?
  end

  def date(day = nil)
    day ||= 1
    Date.new(year, month_num, day.to_i)
  end

  def get_recharge(ignore_recharge = false, ignore_month_recharge = false)
    after_day = Setting.fetch(:recharge_after_day, nil)
    recharge_value = Setting.fetch(:recharge_value, nil)
    month_recharge_value = Setting.fetch(:month_recharge_value, nil)

    recharge = 0

    bm = Date.today.beginning_of_month

    unless paid?
      rv = if month_recharge_value and created_at < bm and !ignore_month_recharge
             month_recharge_value
           elsif recharge_value and Date.today > date(after_day) and !ignore_recharge
             recharge_value
           end

      if rv
        if rv =~ /\A\d+%\z/
          amount*(rv[0..-1].to_i)/100
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
