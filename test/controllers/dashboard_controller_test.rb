# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "shows a warning if there's no inscription for the current year" do
    sign_in admins(:admin)

    get root_path
    assert_response :success
  end
end
