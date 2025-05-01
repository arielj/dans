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

      # check settings fixtures
      # day 10, 10%
      # day 20, 15%
      # month, 20%

      travel_to d1 + 5.days do
        assert_equal ins.get_recharge, Money.new(0)
      end

      travel_to d1 + 11.days do
        assert_equal ins.get_recharge, Money.new(10_00)
      end

      travel_to d1 + 21.days do
        assert_equal ins.get_recharge, Money.new(15_00)
      end

      travel_to d1 + 1.month do
        assert_equal ins.get_recharge, Money.new(20_00)
      end
    end

    test 'can ignore recharges' do
      d1 = Date.today.beginning_of_month

      ins = Installment.new amount: Money.new(100_00), amount_with_discount: Money.new(100_00), year: d1.year, month: d1.month - 1

      # check settings fixtures
      # day 10, 10%
      # day 20, 15%
      # month, 20%

      travel_to d1 + 5.days do
        # 0% recharge
        assert_equal ins.get_recharge, Money.new(0)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # 0 anyway
        assert_equal ins.get_recharge(ignore: :second), Money.new(0) # 0 anyway
        assert_equal ins.get_recharge(ignore: :month), Money.new(0) # 0 anyway
      end

      travel_to d1 + 11.days do
        # 10% recharge
        assert_equal ins.get_recharge, Money.new(10_00)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # ignored
        assert_equal ins.get_recharge(ignore: :second), Money.new(10_00) # first applied
        assert_equal ins.get_recharge(ignore: :month), Money.new(10_00) # first applied
      end

      travel_to d1 + 21.days do
        # 15% recharge
        assert_equal ins.get_recharge, Money.new(15_00)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # ignored
        assert_equal ins.get_recharge(ignore: :second), Money.new(10_00) # first applied
        assert_equal ins.get_recharge(ignore: :month), Money.new(15_00) # second applied
      end

      travel_to d1 + 1.month do
        # 20% recharge
        assert_equal ins.get_recharge, Money.new(20_00)
        assert_equal ins.get_recharge(ignore: :first), Money.new(0) # ignore
        assert_equal ins.get_recharge(ignore: :second), Money.new(10_00) # first applied
        assert_equal ins.get_recharge(ignore: :month), Money.new(15_00) # second applied
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
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 500, description: "cuota"}, with_discount: false)
        assert ins.paid_with_debit?
        ins.payments.destroy_all
        ins.waiting!
        
        # add payment discounted
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 400, description: "cuota"}, with_discount: true)
        assert ins.paid?
        ins.payments.destroy_all
        ins.waiting!
      end

      # with recharges
      travel_to start + 11.days do
        # ignoring recharge
        # add payment with debit
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 500, description: "cuota"}, ignore_recharge: :all, with_discount: false)
        assert ins.paid_with_debit?
        ins.payments.destroy_all
        ins.waiting!

        # add payment discounted
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 400, description: "cuota"}, ignore_recharge: :all, with_discount: true)
        assert ins.paid?
        ins.payments.destroy_all
        ins.waiting!

        # not ignoring recharge
        # add payment with debit
        # $stop = true
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 550, description: "cuota"}, with_discount: false)
        assert ins.paid_with_interests_and_debit?
        ins.payments.destroy_all
        ins.waiting!

        # add payment discounted
        ins.create_payment({ paid_at: Date.today.to_s(:db), amount: 440, description: "cuota"}, with_discount: true)
        assert ins.paid_with_interests?
        ins.payments.destroy_all
        ins.waiting!
      end
    end
  end
end
