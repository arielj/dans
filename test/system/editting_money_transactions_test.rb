# frozen_string_literal: true

require 'application_system_test_case'

class EdittingMoneyTransactionsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome

  setup do
    sign_in admins(:one)
  end

  test 'can edit a person\'s payment' do
    student = FactoryBot.create(:student)

    tran = student.money_transactions.received.create!(amount: 300, description: 'insc')

    visit edit_person_path(student)

    assert_selector "#payment_#{tran.id}"

    find("#edit_payment_#{tran.id}").click

    assert_selector '.modal'

    assert_match 'Editar pago', page.text

    within '.modal' do
      fill_in 'Monto', with: 200
      fill_in 'Detalle', with: 'Test'
      click_button 'Guardar'
    end

    assert_selector '.toast'
    assert_match(/actualizado/i, page.text)

    within "#payment_#{tran.id}" do
      assert_match(/Test/i, page.text)
      assert_no_match(/insc/i, page.text)
      assert_match(/200.00/, page.text)
      assert_no_match(/300.00/, page.text)
    end
  end

  test 'can edit a payment made to a teacher' do
    teacher = FactoryBot.create(:teacher, gender: :female)

    tran = teacher.money_transactions.done.create!(amount: 300, description: 'insc')

    visit edit_person_path(teacher)

    click_link 'Pagos a la profesora'

    assert_selector "#payment_#{tran.id}"

    find("#edit_payment_#{tran.id}").click

    assert_selector '.modal'

    assert_match 'Editar pago', page.text

    within '.modal' do
      fill_in 'Monto', with: 200
      fill_in 'Detalle', with: 'Test'
      click_button 'Guardar'
    end

    assert_selector '.toast'
    assert_match(/actualizado/i, page.text)

    within "#payment_#{tran.id}" do
      assert_match(/Test/i, page.text)
      assert_no_match(/insc/i, page.text)
      assert_match(/200.00/, page.text)
      assert_no_match(/300.00/, page.text)
    end
  end

  test 'can edit a debt payment' do
    student = FactoryBot.create(:student)

    debt = student.debts.create!(amount: 300, description: 'tela')

    visit edit_person_path(student)

    click_link 'Deudas'

    assert_selector "#debt_#{debt.id}"

    within "#debt_#{debt.id}" do
      click_link 'Agregar pago'
    end

    assert_selector '.modal'

    within '.modal' do
      fill_in 'Monto', with: 200
      click_button 'Guardar'
    end

    assert_selector '.toast', text: 'Guardado'

    tran = debt.payments.first

    find("#edit_payment_#{tran.id}").click

    assert_selector '.modal'

    assert_match 'Editar pago', page.text

    within '.modal' do
      fill_in 'Monto', with: 100
      click_button 'Guardar'
    end

    assert_selector '.toast'
    assert_match(/actualizado/i, page.text)

    within "#debt_#{debt.id}" do
      assert_match(/100.00/, page.text)
      assert_no_match(/200.00/, page.text)
    end
  end

  test 'can edit an installment payment' do
    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)
    student.memberships.create(schedules: klass.schedules, amount: 500_00)

    ins = student.memberships.first.installments.first
    tran = ins.create_payment({ amount: 250, description: 'Cuota' }, true, true)

    visit edit_person_path(student)
    click_link 'Cuotas'

    assert_selector "#installment_#{ins.id}"

    find("#edit_payment_#{tran.id}").click

    within '.modal' do
      assert_match 'Editar pago', page.text

      fill_in 'Monto', with: 200
      fill_in 'Detalle', with: 'Test'
      click_button 'Guardar'
    end

    assert_selector '.toast'
    assert_match(/actualizado/i, page.text)

    within "#installment_#{ins.id}" do
      assert_match(/200.00/, page.text)
      assert_no_match(/300.00/, page.text)
    end
  end

  # test 'can edit daily cash movements' do
    
  # end
end
