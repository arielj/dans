# typed: strong
require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test 'has a role included in admin or operator' do
    admin = Admin.new(email: 'some_email@test.com', password: 'pass123', password_confirmation: 'pass123')
    assert admin.invalid?
    assert_not_empty admin.errors[:role]

    admin.role = :admin
    assert admin.valid?

    admin.role = :operator
    assert admin.valid?

    assert_raises(ArgumentError) do
      admin.role = :something
    end
  end
end
