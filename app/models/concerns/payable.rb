# typed: false
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

    enum status: %i[waiting paid paid_with_interests]

    monetize :amount_cents
  end
end
