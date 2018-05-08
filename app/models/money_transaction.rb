class MoneyTransaction < ApplicationRecord
  CATEGORIES = ['installment','inscription','general']
  belongs_to :person, optional: true
  belongs_to :installment, optional: true

  monetize :amount_cents

  validates :amount, numericality: {greater_than: 0}
  validates :description, presence: true

  def self.total_in
    where(done: false).sum(:amount_cents)/100.0
  end

  def self.total_out
    where(done: true).sum(:amount_cents)/100.0
  end

  def self.close_day
    if aux = where('DATE(created_at) = ?', Date.today).last
      aux.update_column(:daily_cash_closer, true)
    end
  end
end
