class Person < ApplicationRecord
  has_many :memberships, inverse_of: :person, dependent: :destroy
  has_many :installments, through: :memberships

  has_many :money_transactions

  validates :name, :lastname, presence: true

  enum gender: [:female, :male, :other]
  enum status: [:inactive, :active]

  scope :birthday_today, -> { where('DAYOFMONTH(birthday) = ? AND MONTH(birthday) = ?', Date.today.day, Date.today.month) }

  def self.genders_for_select
    ds = I18n.t('genders')
    [[ds[0], :female], [ds[1], :male], [ds[2], :other]]
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

  def to_label
    "#{name} #{lastname}"
  end

  def family_members
    self.family_group_id.present? ? Person.where(family_group_id: family_group_id).where.not(id: id) : []
  end

  def add_family_member(person)
    fgid = self.family_group_id || person.family_group_id || self.id
    Person.where(id: [self.id,person.id]).update_all(family_group_id: fgid, updated_at: DateTime.current) == 2
  end

  def remove_family_member(person)
    if person.family_group_id == self.family_group_id
      person.update_column :family_group_id, nil
    end
  end

  def suggest_family(q)
    ids = family_members.map(&:id)+[id]
    Person.where('name LIKE :q OR lastname LIKE :q OR dni LIKE :q', {q: "%#{q}%"}).where.not(id: ids)
  end

  def type
    is_teacher? ? :teacher : :student
  end

  def toggle_active
    to = active? ? :inactive : :active
    update_column(:status, to)
  end
end
