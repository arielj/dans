# typed: strong
require 'test_helper'

class InstallmentTest < ActiveSupport::TestCase
  test 'requires a year' do
    ins = FactoryBot.build(:installment, year: nil)
    assert ins.invalid?
    assert_not_empty ins.errors[:year]

    ins.year = 2020
    assert ins.valid?
  end

  test 'requries a month' do
    ins = FactoryBot.build(:installment, month: nil)
    assert ins.invalid?
    assert_not_empty ins.errors[:month]

    ins.month = :february
    assert ins.valid?
  end
end
