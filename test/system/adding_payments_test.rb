# typed: false
require "application_system_test_case"
 
class AddingPaymentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome

  test 'can ignore the recharge' do
    sign_in admins(:operator)

    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 500_00)
    end

    travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
      ins = student.installments.order(month: :asc).first
      assert_equal Money.new(600_00), ins.to_pay

      visit edit_person_path(student)

      click_link 'Cuotas'

      assert_selector "#installment_#{ins.id}"

      within "#installment_#{ins.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        assert_match 'Restante: $600,00', page.text

        assert_match 'Ignorar recargo a mes vencido', page.text

        find('#ignore_month_recharge_label').click

        assert_match 'Restante: $575,00', page.text

        assert_match 'Ignorar segundo recargo por fecha', page.text

        find('#ignore_second_recharge_label').click

        assert_match 'Ignorar recargo por fecha', page.text

        find('#ignore_recharge_label').click

        assert_match 'Restante: $500,00', page.text

        click_button 'Guardar'
      end

      ins2 = student.installments.order(month: :asc).second

      within "#installment_#{ins2.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        # 500 + 20%
        assert_match 'Restante: $600,00', page.text

        assert_match 'Ignorar recargo a mes vencido', page.text

        find('#ignore_month_recharge_label').click

        # 500 + 15%
        assert_match 'Restante: $575,00', page.text

        assert_match 'Ignorar segundo recargo por fecha', page.text

        find('#ignore_second_recharge_label').click

        # 500 + 10%
        assert_match 'Restante: $550,00', page.text

        assert_match 'Ignorar recargo por fecha', page.text

        find('#ignore_recharge_label').click

        assert_match 'Restante: $500,00', page.text

        fill_in :money_transaction_amount, with: '400'

        click_button 'Guardar'
      end

      within "#installment_#{ins2.id}" do
        assert_match 'Pendiente', page.text
      end
    end
  end

  test 'ignores recharge and set paid status if to_pay is 0' do
    sign_in admins(:operator)

    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 500_00)
    end

    travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
      ins = student.installments.order(month: :asc).first
      assert_equal Money.new(600_00), ins.to_pay

      visit edit_person_path(student)

      click_link 'Cuotas'

      assert_selector "#installment_#{ins.id}"

      within "#installment_#{ins.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        fill_in 'money_transaction_amount', with: '500,00'
        click_button 'Guardar'
      end

      assert_match 'Guardado', page.text

      within "#installment_#{ins.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        assert_match 'Restante: $100,00', page.text

        assert_match 'Ignorar recargo a mes vencido', page.text

        find('#ignore_month_recharge_label').click

        assert_match 'Restante: $75,00', page.text

        assert_match 'Ignorar segundo recargo por fecha', page.text

        find('#ignore_second_recharge_label').click

        assert_match 'Ignorar recargo por fecha', page.text

        find('#ignore_recharge_label').click

        assert_match 'Restante: $0,00', page.text

        click_button 'Guardar'
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