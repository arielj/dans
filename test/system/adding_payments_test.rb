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
      student.memberships.create(schedules: klass.schedules, amount: 500_00, use_fees_with_discount: false)
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

  test 'can add multiple payments at once' do
    skip("flaky")
    sign_in admins(:operator)

    travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
      student = FactoryBot.create(:student)
      family = FactoryBot.create(:student, name: 'Jane')
      student.add_family_member(family)

      klass = FactoryBot.create(:klass_with_schedules)
      student.memberships.create(schedules: klass.schedules, amount: 50_000)
      family.memberships.create(schedules: klass.schedules, amount: 50_000)

      unpaid_installments_count = student.installments_for_multi_payments.size

      ins1 = student.installments.waiting.first
      ins2 = family.installments.waiting.first

      visit edit_person_path(student, tab: :memberships)

      click_link I18n.t('add.payments')

      within '.modal #add_payments' do
        amount_field = find('#amount')

        assert_equal amount_field.value, '0,00'

        student.installments.waiting.each do |ins|
          assert_selector "#installments_to_pay_#{ins.id}"
        end

        family.installments.waiting.each do |ins|
          assert_selector "#installments_to_pay_#{ins.id}"
        end

        find(:css, "#installments_to_pay_#{ins1.id}").set(true)
        find(:css, "#installments_to_pay_#{ins2.id}").set(true)

        # checking two payments with value $500 and $100 recharge
        assert_equal amount_field.value, '1200,00'

        find(:css, "#ignore_recharge_#{ins2.id}").select('Primero')

        # ignore one of the recharge
        assert_equal amount_field.value, '1150,00'

        find(:css, "#ignore_recharge_#{ins2.id}").select('Ignorar')

        # ignore one of the recharge
        assert_equal amount_field.value, '1100,00'

        click_button I18n.t('save.payments')
      end

      sleep(0.1) # somehow it's not waiting enough time to assert

      assert_match I18n.t('saved.payments'), page.body

      assert_equal student.installments_for_multi_payments.count, unpaid_installments_count - 2

      ins1.reload
      ins2.reload

      assert ins1.paid_with_interests?
      assert ins2.paid?
    end
  end
end
