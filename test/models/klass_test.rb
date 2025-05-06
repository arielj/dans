require 'test_helper'

class KlassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "price change updates unpaid installments" do
    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules, fixed_fee_cents: 10_000_00, fixed_fee_with_discount_cents: 9_000_00)
    klass2 = FactoryBot.create(:klass_with_schedules, fixed_fee_cents: 8_500_00, fixed_fee_with_discount_cents: 8_300_00)

    travel_to Time.zone.local(2019, 1, 1, 18, 0, 0) do
      m = student.memberships.create(schedules: klass.schedules + klass2.schedules)

      m.installments.reload.each do |i|
        assert_equal Money.new(18_500_00), i.amount_with_discount
      end
    end

    m = student.memberships.last

    travel_to Time.zone.local(2019, 1, 8, 18, 0, 0) do
      i = m.installments.first
      i.create_payment({ amount: i.to_pay, description: "payment" })
      assert i.paid?
    end

    travel_to Time.zone.local(2019, 1, 20, 18, 0, 0) do
      klass.fixed_fee = Money.new(10_500_00)
      klass.save

      i = m.installments.first
      assert i.paid?
      assert_equal Money.new(18_500_00), i.amount_with_discount

      m.installments.offset(1).each do |i|
        assert_equal Money.new(19_000_00), i.amount_with_discount
      end
    end
  end
end
