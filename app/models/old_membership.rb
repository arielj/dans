class OldMembership < OldRecord
  self.table_name = :memberships

  belongs_to :user, class_name: 'OldUser'

  def for
    cls = "Old#{for_type}".constantize
    cls.find(for_id)
  end

  def to_new
    s = inactive == 1 ? 0 : 1
    m = Membership.new id: id, person_id: student_id, status: s, skip_installments: true
    if for_type == 'Package'
      m.package = Package.find(for_id)
    end
    m.save
    puts m.errors.full_messages
  end
end