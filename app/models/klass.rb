# typed: false
# frozen_string_literal: true

class Klass < ApplicationRecord
  monetize :fixed_fee_cents, allow_nil: true
  monetize :non_regular_fee_cents, allow_nil: true

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

  def students_for_year(year)
    pids = get_installments.includes(:membership).where(year: year).pluck('distinct(person_id)')

    Person.where(id: pids).active
  end

  def students_for_year_and_month(year, month)
    pids = get_installments.includes(:membership).where(year: year, month: month).pluck('distinct(person_id)')

    Person.where(id: pids).active
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
end
