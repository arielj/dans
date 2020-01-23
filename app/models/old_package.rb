# typed: true
# frozen_string_literal: true

class OldPackage < OldRecord
  self.table_name = :packages

  has_and_belongs_to_many :klasses, class_name: 'OldKlass', foreign_key: :package_id, association_foreign_key: :klass_id

  def to_new
    puts "Package #{id}"

    f = fee != 0 ? T.must(fee) * 100 : 0
    f2 = alt_fee != 0 ? T.must(alt_fee) * 100 : 0

    p = Package.new(id: id, name: name, fee: f, alt_fee: f2, person_id: for_user)
    p.schedule_ids = klasses.map(&:schedule_ids).flatten
    p.save!
  end
end
