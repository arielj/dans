class MoneyTransaction < ApplicationRecord
  CATEGORIES = ['installment','inscription','general']
  belongs_to :person, optional: true
  belongs_to :installment, optional: true
end
