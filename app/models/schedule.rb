class Schedule < ApplicationRecord
  belongs_to :klass

  enum day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  def self.days_for_select
    ds = I18n.t('date.day_names')
    [[ds[0], :sunday], [ds[1], :monday], [ds[2], :tueday], [ds[3], :wednesday],
     [ds[4], :thursday], [ds[5], :friday], [ds[6], :saturday]]
  end

  def from_time=(value)
    v = case value
          when /(\d\d)(\d\d)/ then "#{$1}:#{$2}"
          when /(\d)(\d\d)/ then "0#{$1}:#{$2}"
          else value
        end
    self[:from_time] = v
  end

  def to_time=(value)
    v = case value
          when /(\d\d)(\d\d)/ then "#{$1}:#{$2}"
          when /(\d)(\d\d)/ then "0#{$1}:#{$2}"
          else value
        end
    self[:to_time] = v
  end

  def to_label
    "#{klass.name}: #{from_time}-#{to_time}"
  end

  # duration in hours
  def duration
    to = DateTime.parse(to_time, '%H:%M')
    fr = DateTime.parse(from_time, '%H:%M')
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
    t_obj = get_datetime(from_time)
    to = get_datetime(to_time)
    while t_obj < to do
      ints.append(t_obj.strftime("%H:%M"))
      t_obj = t_obj + 30.minutes
    end
    ints
  end

private
  def get_datetime(t)
    h, m = t.split(':').map(&:to_i)
    return DateTime.new(2000,1,1,h,m,0)
  end
end
