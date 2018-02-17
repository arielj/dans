class Person < ApplicationRecord
  has_many :memberships, inverse_of: :person, dependent: :destroy
  has_many :installments, through: :memberships

  validates :name, :lastname, presence: true

end
