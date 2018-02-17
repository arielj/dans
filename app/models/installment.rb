class Installment < ApplicationRecord
  belongs_to :membership
  has_one :person, through: :membership
  has_many :payments, class_name: 'MoneyTransaction'

  monetize :amount_cents
end
