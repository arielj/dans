require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test 'sets and gets hours fees' do
    Setting.set_hours_fees 0.5, [300, 270]
    Setting.set_hours_fees 1.0, [400, 360]
    Setting.set_hours_fees 2, [500, 450]

    assert_equal 300, Setting.get_hours_fee(0.5, with_discount: false)
    assert_equal 360, Setting.get_hours_fee(1, with_discount: true)
    assert_equal 500, Setting.get_hours_fee(2.0, with_discount: false)
  end
end
