# typed: false
# frozen_string_literal: true

class MoneyTransaction < ApplicationRecord
  CATEGORIES = %w[installment inscription general].freeze
  belongs_to :person, optional: true
  belongs_to :payable, optional: true, polymorphic: true

  monetize :amount_cents

  validates :amount, numericality: { greater_than: 0 }

  scope :done, -> { where(done: true) }
  scope :received, -> { where(done: false) }
  scope :today, -> { where('created_at >= ?', Date.today.beginning_of_day) }
  scope :for_day, ->(date) { where('created_at >= ? AND created_at <= ?', date.beginning_of_day, date.end_of_day) }

  def paid_at=(value)
    return if value.blank?

    d = Date.parse(value)
    self.created_at = d.end_of_day if d != Date.today
  end

  def self.total_in
    where(done: false).total
  end

  def self.total_out
    where(done: true).total
  end

  def self.total
    sum(:amount_cents) / 100.0
  end

  def self.close_day
    if (aux = where('DATE(created_at) = ?', Date.today).last)
      aux.update_column(:daily_cash_closer, true)
    end
  end
end
