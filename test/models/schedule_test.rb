require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  test '#to_label interpolates the correct label' do
    sc = FactoryBot.build :schedule, from_time: '10:30', to_time: '12:30', day: 0
    assert_equal "#{sc.klass.name}: 10:30-12:30", sc.to_label
  end
end
