# typed: false
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  class AddMultiPaymentsTest < self
    setup do
      @student = FactoryBot.create(:student)
      @klass = FactoryBot.create(:klass_with_schedules)
      Setting.set :recharge_after_day, '10'
      Setting.set :recharge_value, '10%'
      Setting.set :month_recharge_value, '15%'
      travel_to Time.zone.local(2019, 1, 1, 18, 0, 0) do
        @student.memberships.create(schedules: @klass.schedules, amount: 500_00)
      end
    end

    test 'when amount is not more than the total amount adds payments for the selected installments until amount is depleted' do
      # all unpaid, first with recharge
      travel_to Time.zone.local(2019, 2, 1, 18, 0, 0) do
        installments = @student.installments.waiting.order(id: :asc)

        payments = @student.add_multi_payments(installments.first(3).pluck(:id), 1_300)
        assert_equal 3, payments.size
        assert @student.installments.reload.first.paid_with_interests?
        assert @student.installments.second.paid?
        assert @student.installments.third.payments.present?
        assert_equal Money.new(225_00), @student.installments.third.payments.first.amount

        # add with less than an installment
        ins_id = installments.last.id
        payments = @student.add_multi_payments([ins_id], 100)
        assert_equal 1, payments.size

        ins = @student.installments.find(ins_id)
        assert ins.waiting?
        assert_equal Money.new(100_00), ins.payments.first.amount
      end
    end

    test 'when amount is not more than the total amount returns an error' do
      # all unpaid, first with recharge
      travel_to Time.zone.local(2019, 2, 1, 18, 0, 0) do
        result = @student.add_multi_payments(@student.installments.waiting.first(1).pluck(:id), 1_300)

        assert_equal :excesive_amount, result
        assert_empty @student.money_transactions
      end
    end

    test 'when amount is zero returns an error' do
      result = @student.add_multi_payments(@student.installments.waiting.first(3).pluck(:id), '0,00')

      assert_equal :no_amount, result
      assert_empty @student.money_transactions
    end

    test 'with no installments selected returns an error' do
      result = @student.add_multi_payments([], '100,00')

      assert_equal :no_installments_selected, result
      assert_empty @student.money_transactions
    end
  end

  test '.installments_for_multi_payments returns unpaid installment from all family members' do
    @student = FactoryBot.create(:student)
    family = FactoryBot.create(:student)
    @student.add_family_member(family)

    @klass = FactoryBot.create(:klass_with_schedules)
    @student.memberships.create(schedules: @klass.schedules, amount: 500_00)
    family.memberships.create(schedules: @klass.schedules, amount: 500_00)

    result = @student.installments_for_multi_payments

    @student.installments.waiting.each { |x| assert_includes result, x }
    family.installments.waiting.each { |x| assert_includes result, x }
  end

  test '.missing_inscription? returns false for teachers' do
    teacher = FactoryBot.create(:teacher)
    refute teacher.missing_inscription?(Date.today.year)
  end

  test '.missing_inscription? returns false for students when payments includes "insc"' do
    student = FactoryBot.create(:student)
    assert student.missing_inscription?(Date.today.year)

    student.money_transactions.create(created_at: 1.year.ago, description: 'insc', amount: 500)
    assert student.missing_inscription?(Date.today.year)
    refute student.missing_inscription?(1.year.ago.year)

    student.money_transactions.create(description: 'insc', amount: 400)
    refute student.missing_inscription?(Date.today.year)
  end
end
