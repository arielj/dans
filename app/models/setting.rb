# frozen_string_literal: true

class Setting < ApplicationRecord
  self.primary_key = 'key'
  serialize :value

  @@cache = {}

  def self.cache
    @@cache
  end

  def self.cached(key)
    cached = cache[key]
    if cached && cached[:timestamp] > 2.minutes.ago
      cached[:value]
    else
      nil
    end
  end

  def self.add_to_cache(key, value)
    cache[key] = { value: value, timestamp: DateTime.current }
  end

  def self.fetch(key, default)
    k = key.to_sym

    cached_value = cached(k)
    return cached_value if cached_value

    val = find(k).value rescue default

    add_to_cache(k, val)

    val
  end

  def self.set(key, value)
    k = key.to_sym
    setting = find(k) rescue Setting.new(key: k)
    if setting.value != value
      setting.value = value
      setting.save
    end
    value
  end

  def self.get_all_hours_fees
    fetch('hour_fees', {})
  end

  def self.set_hours_fees(hours, fees)
    aux = hours == hours.to_i ? hours.to_i : hours
    all_fees = get_all_hours_fees
    all_fees[aux.to_s] = fees
    set('hour_fees', all_fees)
  end

  def self.get_hours_fee(hours, with_discount:)
    aux = hours == hours.to_i ? hours.to_i : hours
    fees = get_all_hours_fees
    fees = fees[aux.to_s] || []
    fees = [fees] unless fees.is_a?(Array)
    with_discount ? fees[1] : fees[0]
  end

  def self.opened_range
    o = opening_time_i
    c = closing_time_i - 1
    (o..c).step(100).map { |t| [t, t + 30] }.flatten
  end

  def self.opened_range_str
    opened_range.map do |aux|
      if aux < 10
        "00:0#{aux}"
      elsif aux < 100
        "00:#{aux}"
      else
        mins = aux % 100
        hours = (aux - mins) / 100

        mins = mins < 10 ? "0#{mins}" : mins.to_s
        if hours < 10
          "0#{hours}:#{mins}"
        else
          "#{hours}:#{mins}"
        end
      end
    end
  end

  def self.opening_time_i
    fetch(:opening_time, '00:00').gsub(':', '').to_i
  end

  def self.closing_time_i
    fetch(:closing_time, '24:00').gsub(':', '').to_i
  end

  def self.family_group_discount
    value = Setting.fetch('family_group_discount', nil)
    value = '0' if value.blank?
    value
  end
end
