require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  class AddMultiPaymentsTest < self
    setup do
      @student = FactoryBot.create(:student)
      @klass = FactoryBot.create(:klass_with_schedules)
      travel_to Time.zone.local(2019, 1, 1, 18, 0, 0) do
        @student.memberships.create(schedules: @klass.schedules, amount: 5500_00, amount_with_discount: 500_00)
      end
    end

    test 'when amount is not more than the total amount adds payments for the selected installments until amount is depleted' do
      # all unpaid, first with recharge
      travel_to Time.zone.local(2019, 2, 1, 18, 0, 0) do
        installments = @student.installments.waiting.order(month: :asc)

        payments = @student.add_multi_payments(installments.first(3).pluck(:id), 1_300)
        assert_equal 3, payments.size
        ins = @student.installments.order(month: :asc)
        assert ins.first.paid_with_interests? # 600_00
        assert ins.second.paid? # 500_00
        assert ins.third.payments.present?
        assert_equal Money.new(225_00), ins.third.payments.first.amount

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

  class WithFamilyMembers < self
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
  end

  class MissingInscriptionTest < self
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

  class ActiveFamilyTest < self
    test '.active_family? returns true if family members are active' do
      student = FactoryBot.create(:student, status: :active)

      refute student.family_group?
      refute student.active_family?

      student2 = FactoryBot.create(:student, status: :active)

      refute student2.family_group?

      student.add_family_member(student2)

      assert student.family_group?
      assert student2.family_group?

      assert student.active_family?
      assert student2.active_family?

      student2.inactive!

      refute student.active_family?
    end
  end

  class AgeTest < self
    test '.age prioritizes birthday' do
      student = FactoryBot.build(:student)

      assert_nil student.birthday
      assert_nil student.age

      student.age = 10

      assert_equal 10, student.age

      student.birthday = 8.years.ago.to_date + 5.days

      assert_equal 7, student.age

      student.birthday = 8.years.ago.to_date - 5.days

      assert_equal 8, student.age

      travel_to 4.years.from_now do
        assert_equal 12, student.age
      end
    end
  end

  class MembershipCalculatorTest < self
    def setup
      @student = FactoryBot.create(:student)

      @jazz_prin = FactoryBot.create(:klass_with_schedules, name: "Jazz principiante", fixed_fee_cents: 20_000_00, fixed_alt_fee_cents: 12_500_00, discount: 10)
      @esp_inter_avan = FactoryBot.create(:klass_with_one_schedule, name: "Español intermedio y avanzado", fixed_fee_cents: 16_000_00, discount: 10, fixed_fee_with_discount_cents: 0)
      @tapp = FactoryBot.create(:klass_with_schedules, name: "Tap", fixed_fee_cents: 12_500_00, discount: 5, fixed_fee_with_discount_cents: 0)
      @cofus_inter = FactoryBot.create(:klass_with_schedules, name: "Coreo Funsión intermedio", fixed_fee_cents: 20_000_00, fixed_alt_fee_cents: 12_500_00, discount: 5)
      @cofus_avan = FactoryBot.create(:klass_with_schedules, name: "Coreo Funsión avanzado", fixed_fee_cents: 20_000_00, fixed_alt_fee_cents: 12_500_00, discount: 5)

    end

    test 'single class - one day = 1 week price, no klasses discount' do
      sch_ids = [@jazz_prin.schedules.first.id]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "12500,00", amounts[:subtotal]
      assert_equal "0,00", amounts[:totalDiscount]
      assert_equal "12500,00", amounts[:totalCash]
      assert_equal "17500,00", amounts[:totalDebit]
    end

    test 'single class - two days = full price, no klasses discount' do
      sch_ids = [@jazz_prin.schedules.ids]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "20000,00", amounts[:subtotal]
      assert_equal "0,00", amounts[:totalDiscount]
      assert_equal "20000,00", amounts[:totalCash]
      assert_equal "25000,00", amounts[:totalDebit]
    end

    test 'two classes - one day each = 1 week price each, no klasses discount' do
      sch_ids = [@jazz_prin.schedules.first.id, @cofus_inter.schedules.first.id]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "25000,00", amounts[:subtotal]
      assert_equal "25000,00", amounts[:totalCash]
      assert_equal "0,00", amounts[:totalDiscount]
    end

    test 'two classes - one: 1 day, other: 2 days = 1 week price for one, full price for the other, no discount' do
      sch_ids = [@jazz_prin.schedules.first.id, *@cofus_inter.schedules.ids]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "32500,00", amounts[:subtotal]
      assert_equal "32500,00", amounts[:totalCash]
      assert_equal "0,00", amounts[:totalDiscount]
    end

    test 'three classes - one day each = 1 week price each, 0% discount, not enough complete klasses' do
      sch_ids = [@jazz_prin.schedules.first.id, @cofus_inter.schedules.first.id, @cofus_avan.schedules.first.id ]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "37500,00", amounts[:subtotal]
      assert_equal "37500,00", amounts[:totalCash]
      assert_equal "0,00", amounts[:totalDiscount]
    end

    test 'four classes - one: 1 day, the others full week, 5% discount, 3 completed klasses' do
      sch_ids = [@jazz_prin.schedules.first.id, *@cofus_inter.schedules.ids, *@cofus_avan.schedules.ids, *@esp_inter_avan.schedules.ids ]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "68500,00", amounts[:subtotal]
      assert_equal "65075,00", amounts[:totalCash]
      assert_equal "3425,00", amounts[:totalDiscount]
    end

    test 'five classes - 2 days each = full price, 10% discount' do
      sch_ids = [ *@jazz_prin.schedules.ids, *@cofus_inter.schedules.ids, *@cofus_avan.schedules.ids, *@esp_inter_avan.schedules.ids, *@tapp.schedules.ids ]
      amounts = @student.new_membership_amount_calculator(sch_ids)
      assert_equal "88500,00", amounts[:subtotal]
      assert_equal "79650,00", amounts[:totalCash]
      assert_equal "8850,00", amounts[:totalDiscount]
    end
  end
end
