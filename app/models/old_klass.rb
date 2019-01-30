class OldKlass < OldRecord
  self.table_name = :klasses

  has_many :schedules, class_name: 'OldSchedule', foreign_key: 'klass_id'

  def to_new
    f = normal_fee != 0 ? normal_fee*100 : 0
    s = inactive == 1 ? 0 : 1
    k = Klass.create id: id, name: name, fixed_fee_cents: f, status: s

    days = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
    schedules.each do |sch|
      Schedule.create id: sch.id, klass: k, day: days[sch.day], from_time: sch.from_time, to_time: sch.to_time, room_id: sch.room_id
    end
  end
end
