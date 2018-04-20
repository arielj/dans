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
end
