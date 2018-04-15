class MoneyTransaction < ApplicationRecord
  CATEGORIES = ['installment','inscription','general']
  belongs_to :person, optional: true
  belongs_to :installment, optional: true

  monetize :amount_cents

  validates :amount, numericality: {greater_than: 0}
  validates :description, presence: true

  def self.total_in
    self.where(done: false).sum(:amount_cents)/100.0
  end

  def self.total_out
    self.where(done: true).sum(:amount_cents)/100.0
  end
end
