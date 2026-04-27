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

  if ENV["POSTGRES"]
    scope :birthday_today, -> { where("date_part('day', birthday) = ? AND extract(month from birthday) = ?", DateTime.current.day, DateTime.current.month) }
  else
    scope :birthday_today, -> { where('DAYOFMONTH(birthday) = ? AND MONTH(birthday) = ?', DateTime.current.day, DateTime.current.month) }
  end
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
    Person.genders[gender]
  end

  def name=(value)
    self[:name] = value.titleize
  end

  def lastname=(value)
    self[:lastname] = value.titleize
  end

  def to_label
    "#{name.titleize} #{lastname.titleize}".squeeze(' ')
  end
  alias full_name to_label

  def age
    if birthday
      td = DateTime.current.to_date
      d2 = Date.new(td.year, birthday.month, birthday.day)
      aux = td.year - birthday.year
      d2 > td ? aux - 1 : aux
    else
      self[:age]
    end
  end

  def family_members
    family_group? ? Person.where(family_group_id: family_group_id).where.not(id: id) : Person.none
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

  def add_multi_payments(installment_ids, amount, ignore_recharge = nil, with_discount = true)
    amount = Money.new(amount.to_i * 100)
    return :no_amount if amount.cents.zero?

    installments = installments_for_multi_payments.where(id: installment_ids).order(month: :asc)
    return :no_installments_selected if installments.empty?

    ignore_recharge ||= {}
    to_pay_total = 0
    installments.each do |ins|
      to_pay_total += ins.to_pay(ignore_recharge: ignore_recharge[ins.id.to_s], with_discount: with_discount)
    end
    return :excesive_amount if amount > to_pay_total

    rest = amount
    payments = []
    installments.each do |ins|
      break if rest.zero?

      to_pay = ins.to_pay(ignore_recharge: ignore_recharge[ins.id.to_s], with_discount: with_discount)
      paid_amount = to_pay > rest ? rest : to_pay
      payments << ins.create_payment({ amount: paid_amount, description: 'cuota' }, ignore_recharge: ignore_recharge[ins.id.to_s], with_discount: with_discount)
      rest -= paid_amount
    end

    payments
  end

  def new_membership_amount_calculator(sch_ids, use_manual_discount = false, manual_discount = '', debit_extra: "5000")
    if sch_ids.nil?
      return {
        fixedTotal: "0",
        fixedTotalWithDiscount: "0",
        familyDiscount: "0",
        familyDiscountTotal: "0",
        familyDiscountTotal2: "0",
        manualDiscount: "0",
        manualDiscountTotal: "0",
        manualDiscountTotal2: "0",
        discount: "0",
        klassesDiscount: "0",
        subtotal: "0",
        subtotalWithDiscount: "0",
        discountTotal: "0",
        discountTotalWithDiscount: "0",
        total: "0",
        totalWithDiscount: "0",
        limitedTotal: "0",
        details: [],
        usingFeesWithPackage: true,
        feesPerKlass: {}
      }
    end

    details = []
    fees_per_klass = {}

    debit_extra = Money.new(debit_extra.to_i * 100)

    # count schedules by klass
    schedules_by_klass = {}
    Schedule.where(id: sch_ids).joins(:klass).each do |sch|
      kls = sch.klass
      schedules_by_klass[kls.id] ||= {klass: kls, schedules: []}
      schedules_by_klass[kls.id][:schedules] << sch
    end

    total_klasses = schedules_by_klass.keys.count
    klasses_discount =
      if total_klasses >= 5
        10
      elsif total_klasses >= 3
        5
      else
        0
      end

    details << "Materias: #{total_klasses}"
    details << ""
    details << "Descuento por materias #{klasses_discount}" if klasses_discount > 0
    details << ""

    # process fees based on number of schedules and type of fee
    fixed_total = Money.new(0)
    schedules_by_klass.each do |klass_id, data|
      kls = data[:klass]
      fee =
        if data[:schedules].count < kls.schedules.count && kls.fixed_alt_fee
          kls.fixed_alt_fee
        else
          kls.fixed_fee
        end

      klasses_price_detail =
        if data[:schedules].count == 1
          if kls.schedules.count == 1
            "1 clase de 1 posible"
          else
            "1 clase de #{kls.schedules.count} posibles"
          end
        else
          "#{data[:schedules].count} clases de #{kls.schedules.count} posibles"
        end

      details << "#{kls.name} - #{klasses_price_detail} : $#{fee}"
      fees_per_klass[kls.id] = fee

      fixed_total += fee
      details << "Suma parcial: $#{fixed_total}"
      details << ""
    end

    subtotal = fixed_total

    klasses_discount_total = klasses_discount * subtotal / 100

    # calculate family discount
    family_discount = active_family? ? Setting.fetch('family_group_discount', '0') : 0
    family_discount = family_discount.to_i

    manual_discount = use_manual_discount ? manual_discount.to_i : 0

    total_discount = family_discount + manual_discount + klasses_discount

    # family discount applies to everything
    family_discount_total = subtotal / 100 * family_discount

    details << "Descuento familiar: $#{family_discount_total}" if family_discount > 0

    # manual discount applies only to classes with fixed fee
    manual_discount_total = fixed_total / 100 * manual_discount

    details << "Descuento manual: $#{manual_discount_total}" if manual_discount > 0

    total = subtotal - family_discount_total - manual_discount_total - klasses_discount_total

    details << "Total: $#{total} ($#{total + debit_extra} con débito)"

    limitedTotal = false

    amounts = {
      fixedTotal: fixed_total.to_s,
      familyDiscount: family_discount,
      familyDiscountTotal: family_discount_total.to_s,
      manualDiscount: manual_discount,
      manualDiscountTotal: manual_discount_total.to_s,
      discount: total_discount.to_s,
      klassesDiscount: klasses_discount_total.to_s,
      subtotal: subtotal.to_s,
      discountTotal: (family_discount_total+manual_discount_total+klasses_discount_total).to_s,
      totalCash: total.to_s,
      totalDebit: (total+debit_extra).to_s,
      limitedTotal: limitedTotal,
      details: details,
      feesPerKlass: fees_per_klass
    }

    amounts
  end

  def missing_inscription?(year)
    return false if is_teacher?

    if ENV["POSTGRES"]
      money_transactions.where('extract(year from created_at) = ? AND description LIKE ?', year, '%insc%').empty?
    else
      money_transactions.where('YEAR(created_at) = ? AND description LIKE ?', year, '%insc%').empty?
    end
  end

  def family_group?
    family_group_id.present?
  end

  def active_family?
    return false unless family_group?

    family_members.active.any?
  end

  def self.sources
    distinct(:source).pluck(:source).reject(&:blank?)
  end
end
