# frozen_string_literal: true

class MoneyTransaction < ApplicationRecord
  CATEGORIES = %w[installment inscription general].freeze
  belongs_to :person, optional: true
  belongs_to :payable, optional: true, polymorphic: true

  monetize :amount_cents

  validates :amount, numericality: { greater_than: 0 }

  scope :done, -> { where(done: true) }
  scope :received, -> { where(done: false) }

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
