class Setting < ApplicationRecord
  self.primary_key = 'key'
  serialize :value

  def self.fetch(key, default)
    find(key).try(:value) or default
  end

  def self.set(key, value)
    setting = find(key) || Setting.new(key: key)
    setting.value = value
    setting.save
  end
end
