# frozen_string_literal: true

require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "shows a warning if there's no inscription for the current year" do
    sign_in admins(:admin)

    student = FactoryBot.create(:student)
    get edit_person_path(student)
    assert_response :success

    assert_select '.inscription_warning', 'Falta pagar inscripción'

    student.money_transactions.create(amount: 500, description: 'Insc')
    get edit_person_path(student)
    assert_response :success

    assert_no_match response.body, 'Falta pagar inscripción'
  end
end
