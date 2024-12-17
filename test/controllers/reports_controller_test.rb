# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  %w[installments payments receipts students_with_without_package amount_paid_per_klass debts].each do |report|
    test "allows access to #{report} only to role 'admin'" do
      sign_in admins(:admin)

      get send("reports_#{report}_path")
      assert_response :success

      sign_in admins(:operator)

      get send("reports_#{report}_path")
      assert_response :redirect
    end
  end

  test 'limits date to 7 days ago for "operator" in daily_cash' do
    sign_in admins(:operator)

    get reports_daily_cash_path

    assert_select 'input#date', value: DateTime.current.to_date

    get reports_daily_cash_path(date: 7.days.ago.to_date)

    assert_select 'input#date', value: 7.days.ago.to_date

    get reports_daily_cash_path(date: 8.days.ago.to_date)

    assert_select 'input#date', value: 7.days.ago.to_date
  end

  test 'allows date before 7 days ago for "operator" in daily_cash' do
    sign_in admins(:admin)

    get reports_daily_cash_path

    assert_select 'input#date', value: DateTime.current.to_date

    get reports_daily_cash_path(date: 7.days.ago.to_date)

    assert_select 'input#date', value: 7.days.ago.to_date

    get reports_daily_cash_path(date: 8.days.ago.to_date)

    assert_select 'input#date', value: 8.days.ago.to_date
  end
end
