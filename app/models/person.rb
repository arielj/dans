class Person < ApplicationRecord
  has_many :memberships, -> {order(id: :desc)}, inverse_of: :person, dependent: :destroy
  has_many :installments, through: :memberships

  has_many :debts

  has_many :money_transactions

  has_and_belongs_to_many :klasses_as_teacher, class_name: 'Klass', foreign_key: 'klass_id'

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

  def new_membership_amount_calculator(sch_ids)

    fixed_total = Money.new(0)
    duration = 0
    duration_total = Money.new(0)
    discount = family_group_id.present? ? Setting.fetch('family_group_discount', '0') : 0

    fixed_fee_klasses_ids = []

    Schedule.where(id: sch_ids).joins(:klass).each do |sch|
      f = sch.klass.fixed_fee
      if f and f > 0
        if !fixed_fee_klasses_ids.include?(sch.klass_id)
          fixed_fee_klasses_ids << sch.klass_id
          fixed_total += f
        end
      else
        duration += sch.duration
      end
    end

    duration_total = Money.new(Setting.get_hours_fee(duration).to_i*100)
    subtotal = fixed_total+duration_total

    discount_total = case discount
    when /\A(\d+)%\z/ then subtotal/100*($1.to_f)
    when /\A(\d+)\z/ then Money.new($1.to_i*100)
    else Money.new(0)
    end

    total = subtotal-discount_total

    {fixedTotal: fixed_total.to_s, durationTotal: duration_total.to_s,
     duration: duration, discount: discount, subtotal: subtotal.to_s,
     discountTotal: discount_total.to_s, total: total.to_s}
  end
end
