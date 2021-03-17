require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test "changes classes for installments depending on month day" do
    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)
    klass2 = FactoryBot.create(:klass_with_schedules)

    # create membership with all installments
    travel_to Time.zone.local(2019, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 500, amount_with_discount: 400, use_custom_amount: true)
    end

    membership = student.memberships.first
    membership.create_installments_from = :january
    membership.create_installments_to = :december

    # check that all installments has klass 1
    membership.installments.each do |ins|
      assert_equal ins.klasses.pluck(:id).uniq, [klass.id]
      assert_equal Money.new(500_00), ins.amount
      assert_equal Money.new(400_00), ins.amount_with_discount
    end

    # at june 26 update membership
    travel_to Time.zone.local(2019, 6, 26, 18, 0, 0) do
      membership.schedules = klass2.schedules
      membership.save
    end

    # from january to june: klass 1
    # does not update june cause it's the 26
    membership.installments[0..5].each do |ins|
      assert_equal ins.klasses.pluck(:id).uniq, [klass.id]
    end

    # from july to december: klass 2
    membership.installments[6..-1].each do |ins|
      assert_equal ins.klasses.pluck(:id).uniq, [klass2.id]
    end

    # at june 25 update membership
    travel_to Time.zone.local(2019, 6, 25, 18, 0, 0) do
      membership.schedules = klass2.schedules
      membership.save
    end

    # from january to may: klass 1
    # does update june cause it's before the 26
    membership.installments[0..4].each do |ins|
      assert_equal ins.klasses.pluck(:id).uniq, [klass.id]
    end

    membership.installments[5..-1].each do |ins|
      assert_equal ins.klasses.pluck(:id).uniq, [klass2.id]
    end
  end

  test "updating a membership updates its installments" do
    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)
    klass2 = FactoryBot.create(:klass_with_schedules)

    # create membership with all installments
    travel_to Time.zone.local(2019, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 500, amount_with_discount: 400, use_custom_amount: true)

      m = student.memberships.last

      m.installments.each do |i|
        assert_equal Money.new(50000), i.amount
        assert_equal Money.new(40000), i.amount_with_discount
      end

      m.amount = Money.new(60000)
      m.amount_with_discount = Money.new(50000)
      m.create_installments_from = :january
      m.create_installments_to = :december
      m.update_unpaid_installments = true

      m.save

      m.installments.reload.each do |i|
        assert_equal Money.new(60000), i.amount
        assert_equal Money.new(50000), i.amount_with_discount
      end
    end
  end
end
