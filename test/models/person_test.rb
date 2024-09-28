require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  class AddMultiPaymentsTest < self
    setup do
      @student = FactoryBot.create(:student)
      @klass = FactoryBot.create(:klass_with_schedules)
      travel_to Time.zone.local(2019, 1, 1, 18, 0, 0) do
        @student.memberships.create(schedules: @klass.schedules, amount: 500_00)
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
        assert ins.second.paid_with_debit? # 500_00
        assert ins.third.payments.present?
        assert_equal Money.new(200_00), ins.third.payments.first.amount

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
      Setting.set('calculate_hourly_rates', 'no')

      @jazz_prin = FactoryBot.create(:klass_with_schedules, name: "Jazz principiante", fixed_fee_cents: 20_000_00, fixed_alt_fee_cents: 12_500_00, non_regular_fee_cents: 21_000_00, non_regular_alt_fee_cents: 13_000_00, discount: 10, fixed_fee_with_discount_cents: 0)
      @esp_inter_avan = FactoryBot.create(:klass_with_one_schedule, name: "Español intermedio y avanzado", fixed_fee_cents: 16_000_00, non_regular_fee_cents: 17_000_00, discount: 10, fixed_fee_with_discount_cents: 0)
      @tapp = FactoryBot.create(:klass_with_schedules, name: "Tap", fixed_fee_cents: 12_500_00, discount: 5, fixed_fee_with_discount_cents: 0)
      @cofus_inter = FactoryBot.create(:klass_with_schedules, name: "Coreo Funsión intermedio", fixed_fee_cents: 20_000_00, fixed_alt_fee_cents: 12_500_00, non_regular_fee_cents: 21_000_00, non_regular_alt_fee_cents: 13_000_00, discount: 5, fixed_fee_with_discount_cents: 0)
      @cofus_avan = FactoryBot.create(:klass_with_schedules, name: "Coreo Funsión avanzado", fixed_fee_cents: 20_000_00, fixed_alt_fee_cents: 12_500_00, non_regular_fee_cents: 21_000_00, non_regular_alt_fee_cents: 13_000_00, discount: 5, fixed_fee_with_discount_cents: 0)

    end

    test 'single class - one day = no package price and 1 week price' do
      # non_regular_alt_fee_cents: 13_000_00
      sch_ids = [@jazz_prin.schedules.first.id]
      amounts = @student.new_membership_amount_calculator(sch_ids, apply_klass_discount: true)
      assert_equal "13000,00", amounts[:fixedTotal]
      assert_equal "11700,00", amounts[:total]
      assert_equal "1300,00", amounts[:discountTotal]
    end

    test 'single class - two days = no package price and full price' do
      sch_ids = [@jazz_prin.schedules.ids]
      amounts = @student.new_membership_amount_calculator(sch_ids, apply_klass_discount: true)
      assert_equal "21000,00", amounts[:fixedTotal]
      assert_equal "18900,00", amounts[:total]
      assert_equal "2100,00", amounts[:discountTotal]
    end

    test 'two classes - one day each = no package price and 1 week price each' do
      sch_ids = [@jazz_prin.schedules.first.id, @cofus_inter.schedules.first.id]
      amounts = @student.new_membership_amount_calculator(sch_ids, apply_klass_discount: true)
      assert_equal "26000,00", amounts[:fixedTotal]
      assert_equal "24050,00", amounts[:total]
      assert_equal "1950,00", amounts[:discountTotal]
    end

    test 'two classes - one: 1 day, other: 2 days = package price, 1 week price for one, full price for the other' do
      sch_ids = [@jazz_prin.schedules.first.id, *@cofus_inter.schedules.ids]
      amounts = @student.new_membership_amount_calculator(sch_ids, apply_klass_discount: true)
      assert_equal "32500,00", amounts[:fixedTotal]
      assert_equal "30250,00", amounts[:total]
      assert_equal "2250,00", amounts[:discountTotal]
    end

    test 'three classes - one day each = package price and 1 week price each' do
      sch_ids = [@jazz_prin.schedules.first.id, @cofus_inter.schedules.first.id, @cofus_avan.schedules.first.id ]
      amounts = @student.new_membership_amount_calculator(sch_ids, apply_klass_discount: true)
      assert_equal "37500,00", amounts[:fixedTotal]
      assert_equal "35000,00", amounts[:total]
      assert_equal "2500,00", amounts[:discountTotal]
    end
  end
end
