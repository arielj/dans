# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  %w[installments daily_cash payments].each do |report|
    test "allows access to #{report} only to role 'admin'" do
      sign_in admins(:admin)

      get send("reports_#{report}_path")
      assert_response :success

      sign_in admins(:operator)

      get send("reports_#{report}_path")
      assert_response :redirect
    end
  end
end
