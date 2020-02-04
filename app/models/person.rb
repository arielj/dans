# typed: true
# frozen_string_literal: true

class Person < ApplicationRecord
  has_paper_trail

  has_many :memberships, -> { order(id: :desc) }, inverse_of: :person, dependent: :destroy
  has_many :installments, through: :memberships

  has_many :debts

  has_many :money_transactions

  has_and_belongs_to_many :klasses_as_teacher, class_name: 'Klass', foreign_key: 'klass_id'

  validates :name, :lastname, presence: true

  enum gender: %i[female male other]
  enum status: %i[inactive active]

  scope :birthday_today, -> { where('DAYOFMONTH(birthday) = ? AND MONTH(birthday) = ?', Date.today.day, Date.today.month) }
  scope :teachers, -> { where(is_teacher: true) }
  scope :students, -> { where(is_teacher: false) }
  scope :search, (lambda do |q|
    case q
    when /\A\d+\z/ then where('dni LIKE ?', "%#{q}%")
    when /\A.+\z/ then where('name LIKE :q OR lastname LIKE :q', q: "%#{q}%")
    else none
    end
  end)

  def self.genders_for_select
    ds = I18n.t('genders')
    [[ds[0], :female], [ds[1], :male], [ds[2], :other]]
  end

  def gender_name
    I18n.t('gender')[gender_num]
  end

  def gender_num
    Person.genders[T.must(gender)]
  end

  def name=(value)
    self[:name] = value.capitalize
  end

  def lastname=(value)
    self[:lastname] = value.capitalize
  end

  def to_label
    "#{name} #{lastname}"
  end

  def family_members
    family_group_id.present? ? Person.where(family_group_id: family_group_id).where.not(id: id) : []
  end

  def add_family_member(person)
    fgid = family_group_id || person.family_group_id || id
    self.family_group_id = fgid
    person.family_group_id = fgid
    Person.where(id: [id, person.id]).update_all(family_group_id: fgid, updated_at: DateTime.current) == 2
  end

  def remove_family_member(person)
    return if person.family_group_id != family_group_id

    person.update_column :family_group_id, nil
  end

  def suggest_family(q)
    ids = family_members.map(&:id) + [id]
    Person
      .where('name LIKE :q OR lastname LIKE :q OR dni LIKE :q', q: "%#{q}%")
      .where.not(id: ids)
  end

  def type
    is_teacher? ? :teacher : :student
  end

  def toggle_active
    to = active? ? :inactive : :active
    update_column(:status, to)
  end

  def installments_for_multi_payments
    pids = [id] + family_members.pluck(:id)
    mids = Membership.where(person_id: pids).pluck(:id)
    Installment.where(membership_id: mids).waiting
  end

  def add_multi_payments(installment_ids, amount)
    amount = T.let(Money.new(amount.to_i * 100), T.untyped)
    return :no_amount if amount.cents.zero?

    ins = installments_for_multi_payments.where(id: installment_ids).order(id: :asc)
    return :no_installments_selected if ins.empty?

    to_pay = 0
    to_pay += ins.map(&:to_pay).sum
    return :excesive_amount if amount > to_pay

    rest = amount
    payments = []
    ins.each do |installment|
      break if rest.zero?

      paid_amount = installment.to_pay > rest ? rest : installment.to_pay
      payments << installment.create_payment({ amount: paid_amount }, false, false)
      rest -= paid_amount
    end

    payments
  end

  def new_membership_amount_calculator(sch_ids, use_non_regular_fees = false)
    fixed_total = T.let(Money.new(0), T.untyped)
    duration = 0
    discount = family_group? ? Setting.fetch('family_group_discount', '0') : 0

    fixed_fee_klasses_ids = []

    Schedule.where(id: sch_ids).joins(:klass).each do |sch|
      kls = sch.klass
      f = kls.fixed_fee
      f = kls.non_regular_fee if kls.non_regular_fee && use_non_regular_fees

      if f&.positive?
        unless fixed_fee_klasses_ids.include?(kls.id)
          fixed_fee_klasses_ids << kls.id
          fixed_total += f
        end
      else
        duration += sch.duration
      end
    end

    duration_total = Money.new(Setting.get_hours_fee(duration).to_i * 100)
    subtotal = fixed_total + duration_total

    discount_total = case discount
                     when /\A(\d+)%\z/ then subtotal / 100 * $1.to_f
                     when /\A(\d+)\z/ then Money.new($1.to_i * 100)
                     else Money.new(0)
                     end

    total = subtotal - discount_total

    { fixedTotal: fixed_total.to_s, durationTotal: duration_total.to_s,
      duration: duration, discount: discount, subtotal: subtotal.to_s,
      discountTotal: discount_total.to_s, total: total.to_s }
  end

  def missing_inscription?(year)
    return false if is_teacher?

    money_transactions.where('YEAR(created_at) = ? AND description LIKE ?', year, '%insc%').empty?
  end

  def family_group?
    family_group_id.present?
  end
end
