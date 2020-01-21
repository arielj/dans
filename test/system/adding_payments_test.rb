require "application_system_test_case"
 
class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  test 'can ignore the recharge' do
    log_in

    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)
    Setting.set(:recharge_after_day, 2)
    Setting.set(:recharge_value, '10%')
    Setting.set(:month_recharge_value, '20%')

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 50_000)
    end

    travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
      visit edit_person_path(student)

      click_link 'Cuotas'

      assert_selector "#installment_#{student.installments.first.id}"

      within "#installment_#{student.installments.first.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #add_installment_payment'

      within '.modal #add_installment_payment' do
        assert_match 'Restante: $600,00', page.body

        assert_match 'Ignorar recargo a mes vencido', page.body

        find('#ignore_month_recharge_label').click

        assert_match 'Restante: $550,00', page.body

        assert_match 'Ignorar recargo por fecha', page.body

        find('#ignore_recharge_label').click

        assert_match 'Restante: $500,00', page.body

        click_button 'Guardar pago'
      end

      sleep(1)

      within "#installment_#{student.installments.first.id}" do
        assert_match 'Pagado', page.body
      end
    end
  end

  # it 'can add multiple payments at once' do
  #   log_in

  #   travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
  #     student = FactoryBot.create(:student)
  #     family = FactoryBot.create(:student)
  #     student.add_family_member(family)

  #     klass = FactoryBot.create(:klass_with_schedules)
  #     student.memberships.create(schedules: klass.schedules, amount: 50_000)
  #     family.memberships.create(schedules: klass.schedules, amount: 50_000)

  #     unpaid_installments_count = student.installments_for_multi_payments.size

  #     visit edit_person_path(student, tab: :memberships)

  #     click_link I18n.t('add.payments')

  #     within '.modal #add_payments' do
  #       expect(page).to have_text I18n.t(:select_installments_to_pay)

  #       amount_field = find('#amount')

  #       expect(amount_field.value).to eq '0,00'

  #       student.installments.waiting.each do |ins|
  #         expect(page).to have_selector "#installments_to_pay_#{ins.id}"
  #       end

  #       family.installments.waiting.each do |ins|
  #         expect(page).to have_selector "#installments_to_pay_#{ins.id}"
  #       end

  #       ins = student.installments.waiting.first
  #       find(:css, "#installments_to_pay_#{ins.id}").set(true)

  #       ins = family.installments.waiting.first
  #       find(:css, "#installments_to_pay_#{ins.id}").set(true)

  #       # checking two payments with value $500 and $100 recharge
  #       expect(amount_field.value).to eq '1200,00'

  #       click_button I18n.t('save.payments')
  #     end

  #     expect(page).to have_text I18n.t('saved.payments')

  #     expect(student.installments_for_multi_payments.count).to eq(unpaid_installments_count - 2)
  #   end
  # end
end