# frozen_string_literal: true

require "application_system_test_case"
 
class ReportsInstallmentsTest < ApplicationSystemTestCase
  test 'can filter by installment state' do
    student1 = FactoryBot.create(:student)
    klass1 = FactoryBot.create(:klass_with_schedules)

    student2 = FactoryBot.create(:student)
    klass2 = FactoryBot.create(:klass_with_schedules)

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student1.memberships.create(schedules: klass1.schedules, amount_cents: 500_00, amount_with_discount_cents: 400_00, use_custom_amount: true)
      student2.memberships.create(schedules: klass2.schedules, amount_cents: 600_00, amount_with_discount_cents: 500_00, use_custom_amount: true)

      student1.installments[0..3].each do |ins|
        ins.create_payment({amount: 500, description: 'payment'})
      end
    end

    total_installments = student1.installments.size + student2.installments.size
    paid_installments = 4

    sign_in admins(:admin)

    visit reports_installments_path

    assert_selector 'tbody tr', count: total_installments

    within '.filters' do
      select 'Pagadas', from: :installment_state

      click_on 'Filtrar'
    end

    assert_selector 'tbody tr', count: paid_installments

    within '.filters' do
      select 'Pendientes', from: :installment_state

      click_on 'Filtrar'
    end

    assert_selector 'tbody tr', count: total_installments - paid_installments

    within '.filters' do
      select 'Todas', from: :installment_state

      click_on 'Filtrar'
    end

    assert_selector 'tbody tr', count: total_installments
  end
end
