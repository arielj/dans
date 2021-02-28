# frozen_string_literal: true

class MoneyTransaction < ApplicationRecord
  has_paper_trail

  CATEGORIES = %w[installment inscription general].freeze
  belongs_to :person, optional: true
  belongs_to :payable, optional: true, polymorphic: true

  monetize :amount_cents

  validates :amount, numericality: { greater_than: 0 }

  scope :done, -> { where(done: true) }
  scope :received, -> { where(done: [false, nil]) }
  scope :today, -> { for_day(DateTime.current.to_date) }
  scope :for_day, ->(date) { where(created_at: (date.beginning_of_day..date.end_of_day)) }
  scope :search, ->(q) {
    wheres = []
    values = {}

    q.split(' ').each_with_index do |word, idx|
      placeholder = "q#{idx}"
      wheres << "(description LIKE :#{placeholder} OR people.name LIKE :#{placeholder} OR people.lastname LIKE :#{placeholder})"
      values[placeholder.to_sym] = "%#{word}%"
    end

    references(:person)
      .where(wheres.join(' AND '), values)
  }

  def paid_at=(value)
    return if value.blank?

    d = Date.parse(value)
    self.created_at = d.end_of_day if d != DateTime.current.to_date
  end

  def self.total_in
    where(done: [false, nil]).total
  end

  def self.total_out
    where(done: true).total
  end

  def self.total
    sum(:amount_cents) / 100.0
  end

  def self.close_day
    range = DateTime.current.beginning_of_day..DateTime.current.end_of_day
    if (aux = where(created_at: range).last)
      aux.update_column(:daily_cash_closer, true)
    end
  end

  def self.last_receipt
    order(receipt: :desc).first&.receipt || 0
  end

  def creator
    id = versions.first&.whodunnit
    return nil unless id =~ /\A\d+\z/

    Admin.find_by(id: id)
  end
end
