# typed: strong
require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test 'sets and gets hours fees' do
    Setting.set_hours_fee 0.5, 300
    Setting.set_hours_fee 1.0, 400
    Setting.set_hours_fee 2, 500

    assert_equal 300, Setting.get_hours_fee(0.5)
    assert_equal 400, Setting.get_hours_fee(1)
    assert_equal 500, Setting.get_hours_fee(2.0)
  end
end
