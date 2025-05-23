# frozen_string_literal: true

class Klass < ApplicationRecord
  monetize :fixed_fee_cents, allow_nil: true
  monetize :fixed_fee_with_discount_cents, allow_nil: true
  monetize :fixed_alt_fee_cents, allow_nil: true
  monetize :fixed_alt_fee_with_discount_cents, allow_nil: true
  monetize :non_regular_fee_cents, allow_nil: true
  monetize :non_regular_fee_with_discount_cents, allow_nil: true
  monetize :non_regular_alt_fee_cents, allow_nil: true
  monetize :non_regular_alt_fee_with_discount_cents, allow_nil: true

  has_many :schedules, inverse_of: :klass, dependent: :destroy
  accepts_nested_attributes_for :schedules, reject_if: :all_blank, allow_destroy: true

  has_and_belongs_to_many :packages

  has_many :schedules
  has_many :memberships, through: :schedules
  has_many :students, through: :memberships
  has_and_belongs_to_many :installments
  has_many :memberships_installments, class_name: 'Installment', through: :memberships, source: :installments

  has_and_belongs_to_many :teachers, class_name: 'Person', join_table: :klasses_teachers, association_foreign_key: :teacher_id

  validates :name, presence: true

  enum status: %i[inactive active]

  scope :search, ->(q) { where('name LIKE ?', "%#{q}%") }

  after_update :update_memberships_on_update

  def get_memberships
    memberships.to_a + packages.map(&:memberships).flatten
  end

  def get_installments
    installments.present? ? installments : memberships_installments
  end

  def students
    pids = get_memberships.map(&:person_id)
    Person.where(id: pids)
  end

  def students_for_year(year, inactive: false)
    return Person.none if get_installments.empty?

    pids = get_installments.includes(:membership).where(year: year).pluck('distinct(person_id)')

    scope = Person.where(id: pids)
    inactive ? scope.inactive : scope.active
  end

  def students_for_year_and_month(year, month, inactive: false, hide_unpaid_inactive: true)
    return Person.none if get_installments.empty?

    pids_scope = get_installments.includes(membership: :person).where(year: year, month: month)
    pids_scope = pids_scope.where.not(installments: { status: :waiting }) if inactive && hide_unpaid_inactive
    pids = pids_scope.pluck('distinct(person_id)')

    scope = Person.where(id: pids)
    inactive ? scope.inactive : scope.active
  end


  def memberships_for_year_and_month(year, month)
    paid_mids = get_installments.not_waiting.where(year: year, month: month).pluck('distinct(installments.membership_id)')
    waiting_mids = get_installments.waiting.where(year: year, month: month).pluck('distinct(installments.membership_id)')

    # only count active persons for unpaid installments
    Membership.where(id: paid_mids).or(Membership.where(id: waiting_mids, person_id: Person.active.pluck(:id)))
  end

  def toggle_active
    to = active? ? :inactive : :active
    update_column(:status, to)
  end

  def self.statuses_for_select
    ds = I18n.t('statuses.klass')
    [[ds[0], :inactive], [ds[1], :active]]
  end

  def debit_fee(field)
    # fee = send("#{field}_with_discount")
    # if fee && fee > Money.new(0)
    #   fee
    # else
    #  send(field) * (100 + debit_value) / 100
    # end
    Money.new(500000)
  end

  def debit_value
    @debit_value ||=
      case Setting.fetch(:debit_extra_charge, '0')
        when /\A(\d+)%?\z/ then $1.to_f
        else 0
      end
  end

  def update_memberships_on_update
    # don't update membership if none of the fees changed
    return if [:fixed_fee, :fixed_alt_fee, :non_regular_fee, :non_regular_alt_fee].none? do |attr|
      send("saved_change_to_#{attr}_cents?")
    end

    memberships.includes(:installments).where(use_custom_amount: false, installments: {status: :waiting, year: Date.today.year}).each do |mem|
     mem.create_installments_from = :january
     mem.create_installments_to = :december
     mem.update_unpaid_installments = true
     mem.update_paid_installments = false
     mem.save
    end
  end
end
