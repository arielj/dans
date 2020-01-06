require 'rails_helper'

RSpec.describe Person, type: :model do
  describe '.add_multi_payments' do
    let(:student) { FactoryBot.create(:student) }
    let(:klass) { FactoryBot.create(:klass_with_schedules) }

    before(:each) do
      travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
        student.memberships.create(schedules: klass.schedules, amount: 50_000)
      end
    end

    context 'amount is not more than the total amount' do
      it 'adds payments for the selected installments until amount is depleted' do
        # all unpaid, first with recharge
        travel_to Time.zone.local(2020, 2, 1, 18, 0, 0) do
          installments = student.installments.waiting.order(id: :asc)

          payments = student.add_multi_payments(installments.first(3).pluck(:id), 1300)

          expect(payments.size).to eq 3
          expect(student.installments.reload.first).to be_paid_with_interests
          expect(student.installments.second).to be_paid
          expect(student.installments.third.payments).to be_present
          expect(student.installments.third.payments.first.amount).to eq Money.new(20_000)

          # add with less than an installment
          ins_id = installments.last.id
          payments = student.add_multi_payments([ins_id], 100)
          expect(payments.size).to eq 1

          ins = student.installments.find(ins_id)
          expect(ins).to be_waiting
          expect(ins.payments.first.amount).to eq Money.new(10_000)
        end
      end
    end

    context 'amount is not more than the total amount' do
      it 'returns an error' do
        # all unpaid, first with recharge
        travel_to Time.zone.local(2020, 2, 1, 18, 0, 0) do
          result = student.add_multi_payments(student.installments.waiting.first(1).pluck(:id), 1300)

          expect(result).to eq :excesive_amount
          expect(student.money_transactions).to be_empty
        end
      end
    end

    context 'amount is zero' do
      it 'returns an error' do
        result = student.add_multi_payments(student.installments.waiting.first(3).pluck(:id), '0,00')

        expect(result).to eq :no_amount
        expect(student.money_transactions).to be_empty
      end
    end

    context 'with no installments selected' do
      it 'returns an error' do
        result = student.add_multi_payments([], '100,00')

        expect(result).to eq :no_installments_selected
        expect(student.money_transactions).to be_empty
      end
    end
  end

  describe '.installments_for_multi_payments' do
    it 'returns unpaid installment from all family members' do
      student = FactoryBot.create(:student)
      family = FactoryBot.create(:student)
      student.add_family_member(family)

      klass = FactoryBot.create(:klass_with_schedules)
      student.memberships.create(schedules: klass.schedules, amount: 50_000)
      family.memberships.create(schedules: klass.schedules, amount: 50_000)

      result = student.installments_for_multi_payments

      student.installments.waiting.each { |x| expect(result).to include x }
      family.installments.waiting.each { |x| expect(result).to include x }
    end
  end
end
