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

  def self.get_hours_fees
    fetch("hour_fees", {})
  end

  def self.set_hours_fee(hours, fee)
    aux = hours == hours.to_i ? hours.to_i : hours
    fees = get_hours_fees
    fees[aux.to_s] = fee
    set("hour_fees", fees)
  end

  def self.get_hours_fee(hours)
    aux = hours == hours.to_i ? hours.to_i : hours
    fees = get_hours_fees
    fees[aux.to_s]
  end
end
