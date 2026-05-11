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

    # cached_value = cached(k)
    # return cached_value if cached_value

    val = find(k).value rescue default

    # add_to_cache(k, val)

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

  def self.get(key)
    find(key).value rescue nil
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
end
