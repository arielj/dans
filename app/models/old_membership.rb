class OldMembership < OldRecord
  self.table_name = :memberships

  belongs_to :user, class_name: 'OldUser'

  def for
    cls = "Old#{for_type}".constantize
    cls.find(for_id)
  end

  def to_new
    puts "Membership #{id}"

    s = inactive == 1 ? 0 : 1
    m = Membership.new id: id, person_id: student_id, status: s, skip_installments: true

    m.package = Package.find(for_id) if for_type == 'Package'

    m.save!
  end
end
