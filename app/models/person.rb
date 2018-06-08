class Person < ApplicationRecord
  has_many :memberships, inverse_of: :person, dependent: :destroy
  has_many :installments, through: :memberships

  validates :name, :lastname, presence: true

  enum gender: [:female, :male]

  scope :birthday_today, -> { where('DAYOFMONTH(birthday) = ? AND MONTH(birthday) = ?', Date.today.day, Date.today.month) }

  def self.genders_for_select
    ds = I18n.t('genders')
    [[ds[0], :female], [ds[1], :male]]
  end

  def gender_name
    I18n.t('gender')[gender_num]
  end

  def month_num
    Person.genders[gender]
  end

  def name=(value)
    self[:name] = value.capitalize
  end

  def lastname=(value)
    self[:lastname] = value.capitalize
  end

end
