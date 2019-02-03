class Schedule < ApplicationRecord
  belongs_to :klass
  belongs_to :room

  has_and_belongs_to_many :memberships

  enum day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  def self.days_for_select
    ds = I18n.t('date.day_names')
    [[ds[0], :sunday], [ds[1], :monday], [ds[2], :tuesday], [ds[3], :wednesday],
     [ds[4], :thursday], [ds[5], :friday], [ds[6], :saturday]]
  end

  def from_time=(value)
    v = case value
          when /(\d\d):(\d\d)/ then "#{$1}#{$2}".to_i
          when /(\d):(\d\d)/ then "#{$1}:#{$2}".to_i
          else value
        end
    self[:from_time] = v
  end

  def to_time=(value)
    v = case value
          when /(\d\d):(\d\d)/ then "#{$1}#{$2}".to_i
          when /(\d):(\d\d)/ then "#{$1}#{$2}".to_i
          else value
        end
    self[:to_time] = v
  end

  def from_time_s
    time_to_s from_time
  end

  def to_time_s
    time_to_s to_time
  end

  def to_label
    "#{klass.name}: #{from_time_s}-#{to_time_s}"
  end

  # duration in hours
  def duration
    to = DateTime.parse(to_time_s, '%H:%M')
    fr = DateTime.parse(from_time_s, '%H:%M')
    (to-fr)*24.0
  end

  def day_name
    I18n.t('date.day_names')[Schedule.days[day]]
  end

  # returns schedule intervals separated by 30 minutes:
  # if schedule goes from 20:00 to 21:30, it returns
  # ['20:00','20:30','21:00']
  def get_intervals
    ints = []
    t_obj = get_datetime(from_time_s)
    to = get_datetime(to_time_s)
    while t_obj < to do
      ints.append(t_obj.strftime("%H:%M"))
      t_obj = t_obj + 30.minutes
    end
    ints
  end

  def self.by_room_for_day(wday)
    Room.all.map do |room|
      [room, room.schedules_for_day(wday)]
    end.to_h
  end

private
  def get_datetime(t)
    h, m = t.split(':').map(&:to_i)
    return DateTime.new(2000,1,1,h,m,0)
  end

  def time_to_s(t)
    t ||= 0
    if t < 10
      "00:0#{t}"
    elsif t < 60
      "00:#{t}"
    elsif t < 1000
      "0#{t}".insert(-3, ':')
    else
      t.to_s.insert(-3, ':')
    end
  end
end
