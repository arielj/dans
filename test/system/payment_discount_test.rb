# frozen_string_literal: true

require 'application_system_test_case'

class PaymentDiscountTest < ApplicationSystemTestCase
  test 'can pick discounted price when paying' do
    sign_in admins(:operator)

    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)

    travel_to Time.zone.local(2020, 1, 1, 18, 0, 0) do
      student.memberships.create(schedules: klass.schedules, amount_cents: 500_00, amount_with_discount_cents: 400_00, use_custom_amount: true)

      ins = student.installments.order(month: :asc).first
      assert_equal Money.new(500_00), ins.amount
      assert_equal Money.new(400_00), ins.amount_with_discount

      visit edit_person_path(student)

      click_link 'Cuotas'

      assert_selector "#installment_#{ins.id}"

      within "#installment_#{ins.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        assert_match 'Restante: $500,00 (o $400,00)', page.text

        assert_equal '500,00', find('#money_transaction_amount').value

        click_checkbox("#use_amount_with_discount")

        assert_equal '400,00', find('#money_transaction_amount').value

        click_checkbox("#use_amount_with_discount")

        assert_equal '500,00', find('#money_transaction_amount').value

        click_button 'Guardar'
      end

      assert_text 'Guardado'

      ins.reload
      assert ins.paid?
      assert_equal Money.new(500_00), ins.amount_paid

      ins2 = student.installments.order(month: :asc).second

      assert_selector "#installment_#{ins2.id}"

      within "#installment_#{ins2.id}" do
        click_link 'Agregar pago'
      end

      assert_selector '.modal #installment_payment'

      within '.modal #installment_payment' do
        assert_match 'Restante: $500,00 (o $400,00)', page.text

        assert_equal '500,00', find('#money_transaction_amount').value

        click_checkbox("#use_amount_with_discount")

        assert_equal '400,00', find('#money_transaction_amount').value

        click_button 'Guardar'
      end

      assert_text 'Guardado'

      ins2.reload
      assert ins2.paid?
      assert_equal Money.new(400_00), ins2.amount_paid
    end
  end
end