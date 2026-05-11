require 'test_helper'

class InstallmentTest < ActiveSupport::TestCase
  class ValidationsTest < self
    test 'requires a year' do
      ins = FactoryBot.build(:installment, year: nil)
      assert ins.invalid?
      assert_not_empty ins.errors[:year]

      ins.year = 2020
      assert ins.valid?
    end

    test 'requires a month' do
      ins = FactoryBot.build(:installment, month: nil)
      assert ins.invalid?
      assert_not_empty ins.errors[:month]

      ins.month = :february
      assert ins.valid?
    end
  end

  class GetRechargeTest < self
    test 'returns the correct recharge' do
      d1 = Date.today.beginning_of_month

      ins = Installment.new amount: Money.new(100_00), amount_with_discount: Money.new(100_00), year: d1.year, month: d1.month - 1

      # check surcharge constants in constants.rb
      # day 10, 10%
      # day 15, 15%

      travel_to d1 + 5.days do
        assert_equal ins.get_recharge, Money.new(0)
      end

      travel_to d1 + 11.days do
        assert_equal ins.get_recharge, Money.new(10_00)
      end

      travel_to d1 + 16.days do
        assert_equal ins.get_recharge, Money.new(15_00)
      end
    end

    test 'can ignore surcharges' do
      d1 = Date.today.beginning_of_month

      ins = Installment.new amount: Money.new(100_00), amount_with_discount: Money.new(100_00), year: d1.year, month: d1.month - 1

      # check settings fixtures
      # day 10, 10%
      # day 15, 15%

      travel_to d1 + 5.days do
        # 0% recharge
        assert_equal ins.get_recharge, Money.new(0)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # 0 anyway
        assert_equal ins.get_recharge(ignore: :second), Money.new(0) # 0 anyway
      end

      travel_to d1 + 11.days do
        # 10% recharge
        assert_equal ins.get_recharge, Money.new(10_00)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # ignored
        assert_equal ins.get_recharge(ignore: :second), Money.new(10_00) # first applied
      end

      travel_to d1 + 16.days do
        # 15% recharge
        assert_equal ins.get_recharge, Money.new(15_00)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # ignored
        assert_equal ins.get_recharge(ignore: :second), Money.new(10_00) # first applied
      end
    end
  end

  class Payments < self
    test 'sets paid status correctly' do
      start = Date.today.beginning_of_month
      student = FactoryBot.create(:student)
      klass = FactoryBot.create(:klass_with_schedules)
      klass2 = FactoryBot.create(:klass_with_schedules)
      mem = student.memberships.create(schedules: klass.schedules, amount: 500, amount_with_discount: 400, use_custom_amount: true)
      ins = mem.installments.where(year: start.year, month: start.month - 1).first

      travel_to start + 5.days do
        assert_equal ins.get_recharge, Money.new(0)
        # no recharges
        # add payment with debit
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 5500, description: "cuota"}, add_debit_extra: true)
        assert ins.paid_with_debit?
        ins.payments.destroy_all
        ins.waiting!
        
        # add payment discounted
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 400, description: "cuota"}, add_debit_extra: false)
        assert ins.paid?
        ins.payments.destroy_all
        ins.waiting!
      end

      # with recharges
      travel_to start + 11.days do
        # ignoring recharge
        # add payment with debit
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 5500, description: "cuota"}, ignore_recharge: :all, add_debit_extra: true)
        assert ins.paid_with_debit?
        ins.payments.destroy_all
        ins.waiting!

        # add payment discounted
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 400, description: "cuota"}, ignore_recharge: :all, add_debit_extra: false)
        assert ins.paid?
        ins.payments.destroy_all
        ins.waiting!

        # not ignoring recharge
        # add payment with debit
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 5550, description: "cuota"}, add_debit_extra: true)
        assert ins.paid_with_interests_and_debit?
        ins.payments.destroy_all
        ins.waiting!

        # add payment discounted
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 440, description: "cuota"}, add_debit_extra: false)
        assert ins.paid_with_interests?
        ins.payments.destroy_all
        ins.waiting!
      end
    end
  end
end
