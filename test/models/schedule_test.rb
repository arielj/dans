# typed: false
require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  test '#duration returns the schedule duration as decimal value' do
    sc = FactoryBot.build :schedule, from_time: '10:30', to_time: '12:30'
    assert_equal 2, sc.duration

    sc = FactoryBot.build :schedule, from_time: '11:30', to_time: '12:00'
    assert_equal 0.5, sc.duration

    sc = FactoryBot.build :schedule, from_time: '10:00', to_time: '11:30'
    assert_equal 1.5, sc.duration

    sc = FactoryBot.build :schedule, from_time: '10:45', to_time: '12:00'
    assert_equal 1.25, sc.duration
  end

  test '#to_label interpolates the correct label' do
    sc = FactoryBot.build :schedule, from_time: '10:30', to_time: '12:30', day: 0
    assert_equal "#{sc.klass.name}: 10:30-12:30", sc.to_label
  end
end
