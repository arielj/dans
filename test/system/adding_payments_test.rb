require "application_system_test_case"
 
class AddingPaymentsTest < ApplicationSystemTestCase
  setup do
    sign_in admins(:operator)
  end

  test 'can ignore the recharge' do
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
        assert_equal "575,00", find("#money_transaction_amount").value

        assert_match 'Ignorar segundo recargo por fecha', page.text

        find('#ignore_second_recharge_label').click

        assert_match 'Ignorar recargo por fecha', page.text

        find('#ignore_recharge_label').click

        assert_match 'Restante: $500,00', page.text
        assert_equal "500,00", find("#money_transaction_amount").value

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

      assert_selector ".modal", count: 0

      assert_match I18n.t('saved.payments'), page.body

      assert_equal student.installments_for_multi_payments.count, unpaid_installments_count - 2

      ins1.reload
      ins2.reload

      assert ins1.paid_with_interests?
      assert ins2.paid?
    end
  end

  test 'uses rest of the money for the next installment' do
    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 500_00, use_fees_with_discount: false)
    end

    travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
      ins = student.installments.order(month: :asc).first
      next_ins = ins.next_installment
      assert_equal Money.new(600_00), ins.to_pay
      assert_equal Money.new(600_00), next_ins.to_pay

      visit edit_person_path(student)

      click_link 'Cuotas'

      assert_selector "#installment_#{ins.id}"

      within "#installment_#{ins.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        fill_in 'money_transaction_amount', with: '700,00'

        assert_match "El resto ($100) se va a asignar a la cuota de #{next_ins.month_name}", page.text

        fill_in 'money_transaction_amount', with: '600,00'

        refute_match "El resto ($0) se va a asignar a la cuota de #{next_ins.month_name}", page.text

        fill_in 'money_transaction_amount', with: '700,00'

        assert_match "El resto ($100) se va a asignar a la cuota de #{next_ins.month_name}", page.text

        click_button 'Guardar'
      end

      assert_match 'Guardado', page.text

      assert_equal Money.new(500_00), next_ins.reload.to_pay
    end
  end

  test 'prevents save if too high money and no next installment' do
    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount: 500_00, use_fees_with_discount: false)
    end

    travel_to Time.zone.local(2020, 7, 1, 18, 0, 0) do
      ins = student.installments.order(month: :asc).last
      assert_equal Money.new(500_00), ins.to_pay
      assert_nil ins.next_installment

      visit edit_person_path(student)

      click_link 'Cuotas'

      assert_selector "#installment_#{ins.id}"

      within "#installment_#{ins.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        fill_in 'money_transaction_amount', with: '600,00'

        refute_match 'El resto ($100) se va a asignar', page.text
        assert_match 'Monto excede resto y no hay cuota siguiente.', page.text
        assert_selector "button[value='save'][disabled]"
        assert_selector "button[value='save_and_receipt'][disabled]"

        fill_in 'money_transaction_amount', with: '400,00'

        assert_selector "button[value='save']:not([disabled])"
        assert_selector "button[value='save_and_receipt']:not([disabled])"

        click_button 'Guardar'
      end

      assert_match 'Guardado', page.text
    end
  end
end
