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

  def add_multi_payments(installment_ids, amount, ignore_recharge = nil, add_debit_extra = false)
    amount = Money.new(amount.to_i * 100)
    return :no_amount if amount.cents.zero?

    installments = installments_for_multi_payments.where(id: installment_ids).order(month: :asc)
    return :no_installments_selected if installments.empty?

    ignore_recharge ||= {}
    to_pay_total = 0
    installments.each do |ins|
      to_pay_total += ins.to_pay(ignore_recharge: ignore_recharge[ins.id.to_s], add_debit_extra: add_debit_extra)
    end
    return :excesive_amount if amount > to_pay_total

    rest = amount
    payments = []
    installments.each do |ins|
      break if rest.zero?

      to_pay = ins.to_pay(ignore_recharge: ignore_recharge[ins.id.to_s], add_debit_extra: add_debit_extra)
      paid_amount = to_pay > rest ? rest : to_pay
      payments << ins.create_payment({ amount: paid_amount, description: 'cuota' }, ignore_recharge: ignore_recharge[ins.id.to_s], add_debit_extra: add_debit_extra)
      rest -= paid_amount
    end

    payments
  end

  def new_membership_amount_calculator(sch_ids, use_manual_discount = false, manual_discount = '')
    if sch_ids.nil?
      return {
        familyDiscountPer: 0,
        teacherDiscountPer: 0,
        klassesDiscountPer: 0,
        manualDiscountPer: 0,
        useManualDiscount: false,
        totalDiscountPer: 0,
        subtotal: "0,00",
        totalDiscount: "0,00",
        totalCash: "0,00",
        totalDebit: "0,00",
        details: [],
        feesPerKlass: {}
      }
    end

    details = []
    fees_per_klass = {}

    # count schedules by klass
    schedules_by_klass = {}
    Schedule.where(id: sch_ids).joins(:klass).each do |sch|
      kls = sch.klass
      schedules_by_klass[kls.id] ||= {klass: kls, schedules: []}
      schedules_by_klass[kls.id][:schedules] << sch
    end

    # process fees based on number of schedules and type of fee
    subtotal = Money.new(0)
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
      fees_per_klass[kls.id] = fee.to_s

      subtotal += fee
      details << "Suma parcial: $#{subtotal}"
      details << ""
    end

    total_discount_per = 0
    family_discount_per = 0
    teacher_discount_per = 0
    klasses_discount_per = 0
    manual_discount_per = 0
    klasses_count = schedules_by_klass.keys.count

    if use_manual_discount
      manual_discount_per = use_manual_discount ? manual_discount.to_i : 0
      details << "Descuento manual: #{manual_discount_per}%" if manual_discount_per > 0
      total_discount_per = manual_discount_per
    else
      klasses_discount_per =
        if klasses_count >= 5
          10
        elsif klasses_count >= 3
          5
        else
          0
        end

      details << "Descuento por materias (#{klasses_count} materias): #{klasses_discount_per}%" if klasses_discount_per > 0

      # calculate family discount
      family_discount_per = 0
      if active_family?
        family_discount_per = FAMILY_DISCOUNT_PERCENT
        details << "Descuento por grupo familiar: #{family_discount_per}%" if family_discount_per > 0
      end

      teacher_discount_per = 0
      if is_teacher
        teacher_discount_per = TEACHER_DISCOUNT_PERCENT
        details << "Descuento por profe: #{teacher_discount_per}%" if teacher_discount_per > 0
      end

      total_discount_per = klasses_discount_per + family_discount_per + teacher_discount_per
    end

    total_discount = Money.new(0)
    if total_discount_per > 0
      total_discount = subtotal * total_discount_per / 100
      details << "Descuento total (#{total_discount_per}%): $#{total_discount}"
    end
    
    total = subtotal - total_discount
    
    details << ""
    details << "Total: $#{total} ($#{total + DEBIT_EXTRA} con débito)"

    amounts = {
      familyDiscountPer: family_discount_per,
      teacherDiscountPer: teacher_discount_per,
      klassesCount: klasses_count,
      klassesDiscountPer: klasses_discount_per,
      manualDiscountPer: manual_discount_per,
      useManualDiscount: use_manual_discount,
      totalDiscountPer: total_discount_per,
      subtotal: subtotal.to_s,
      totalDiscount: total_discount.to_s,
      totalCash: total.to_s,
      totalDebit: (total+DEBIT_EXTRA).to_s,
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
