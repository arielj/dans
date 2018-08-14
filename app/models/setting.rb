class Setting < ApplicationRecord
  self.primary_key = 'key'
  serialize :value

  def self.cache
    @@cache ||= {}
  end

  def self.fetch(key, default)
    k = key.to_sym
    return cache[k] if cache[k]
    cache[k] = find(k).value rescue default
  end

  def self.set(key, value)
    k = key.to_sym
    setting = find(k) rescue Setting.new(key: k)
    if setting.value != value
      setting.value = value
      setting.save
    end
    cache[k] = value
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
