class OldSchedule < OldRecord
  self.table_name = :schedules

  belongs_to :klass, class_name: 'OldKlass'
  belongs_to :room, class_name: 'OldRoom'
end
