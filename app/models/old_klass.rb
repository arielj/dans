# frozen_string_literal: true

class OldKlass < OldRecord
  self.table_name = :klasses

  has_many :schedules, class_name: 'OldSchedule', foreign_key: 'klass_id'

  has_and_belongs_to_many :teachers, class_name: 'OldUser', join_table: :klasses_teachers, foreign_key: :klass_id, association_foreign_key: :teacher_id

  has_and_belongs_to_many :packages, class_name: 'OldPackage', foreign_key: :klass_id, association_foreign_key: :package_id

  def to_new
    puts "Klass #{id}"

    unless (k = Klass.where(id: id).first)
      f = normal_fee != 0 ? normal_fee * 100 : 0
      s = inactive == 1 ? 0 : 1
      k = Klass.create! id: id, name: name, fixed_fee_cents: f, status: s

      days = %i[monday tuesday wednesday thursday friday saturday sunday]
      schedules.each do |sch|
        Schedule.create! id: sch.id, klass: k, day: days[sch.day], from_time: sch.from_time, to_time: sch.to_time, room_id: sch.room_id
      end
    end
    new_teachers = Person.where(id: teacher_ids)
    k.teachers = new_teachers
    k.save!
  end
end
