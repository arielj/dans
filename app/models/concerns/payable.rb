# frozen_string_literal: true

module Payable
  extend ActiveSupport::Concern

  def amount_paid
    payments.select(&:persisted?).map(&:amount).sum
  end

  def paid?
    !waiting?
  end

  included do
    has_many :payments, class_name: 'MoneyTransaction', as: :payable

    enum status: %i[waiting paid paid_with_interests paid_with_debit paid_with_interests_and_debit]

    monetize :amount_cents
  end
end
