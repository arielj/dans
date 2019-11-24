# frozen_string_literal: true

module Payable
  extend ActiveSupport::Concern

  def amount_paid
    payments.map(&:amount).sum
  end

  def paid?
    !waiting?
  end

  included do
    has_many :payments, class_name: 'MoneyTransaction', inverse_of: :payable, foreign_key: :payable_id, foreign_type: :payable_type

    enum status: %i[waiting paid paid_with_interests]

    monetize :amount_cents
  end
end
