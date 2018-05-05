class Setting < ApplicationRecord
  self.primary_key = 'key'
  serialize :value

  def self.fetch(key, default)
    find(key).value rescue default
  end

  def self.set(key, value)
    setting = find(key) rescue Setting.new(key: key)
    setting.value = value
    setting.save
  end

  def self.set_hours_fee(hours, fee)
    aux = hours == hours.to_i ? hours.to_i : hours
    set("hour_fee_#{aux}",fee)
  end

  def self.get_hours_fee(hours)
    aux = hours == hours.to_i ? hours.to_i : hours
    fetch("hour_fee_#{aux}", nil)
  end
end
