class Debt < ApplicationRecord
  include Payable
  belongs_to :person

  validates :description, :amount, presence: true
  validates :amount, numericality: {greater_than: 0}

  def to_pay
    return 0 if paid?
    amount-amount_paid
  end

  def create_payment(attrs)
    payment = person.money_transactions.build attrs
    payment.done = false
    rest = to_pay
    if payment.amount > rest
      payment.errors.add(:base, :amount_too_high)
    else
      payments << payment
      if payment.save
        if payment.amount == rest
          if amount_paid > amount
            self.paid_with_interests!
          else
            self.paid!
          end
        end
      end
    end
    payment
  end
end