# frozen_string_literal: true

class Klass < ApplicationRecord
  monetize :fixed_fee_cents

  has_many :schedules, inverse_of: :klass, dependent: :destroy
  accepts_nested_attributes_for :schedules, reject_if: :all_blank, allow_destroy: true

  has_and_belongs_to_many :packages

  has_many :schedules
  has_many :memberships, through: :schedules

  has_many :students, through: :memberships

  has_and_belongs_to_many :teachers, class_name: 'Person', join_table: :klasses_teachers, association_foreign_key: :teacher_id

  validates :name, presence: true

  enum status: %i[inactive active]

  scope :search, ->(q) { where('name LIKE ?', "%#{q}%") }

  def get_memberships
    memberships + packages.map(&:memberships).flatten
  end

  def students
    pids = get_memberships.map(&:person_id)
    Person.where(id: pids)
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
