# frozen_string_literal: true

require 'test_helper'

class KlassesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "can edit a klass" do
    sign_in admins(:admin)

    klass = FactoryBot.create(:klass, name: 'Old name')

    put klass_path(klass), params: {klass: {name: 'New name'}}

    assert_equal 'New name', klass.reload.name
  end
end
