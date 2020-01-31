# typed: frozen_string_literal: true

require "application_system_test_case"
 
class DashboardTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome

  test 'can add daily cash movements' do
    sign_in admins(:one)

    visit root_path

    click_on 'Agregar movimiento'

    within '.modal' do
      fill_in 'Detalle', with: 'Papel'
      fill_in 'Monto', with: '100'

      find('#money_transaction_done_true').ancestor('label').click()
      click_button 'Guardar'
    end

    assert_selector '.toast', text: 'Guardado'

    within '.dailycash' do
      assert_selector 'td', text: 'Papel'
      assert_selector 'td', text: '100,00'
    end
  end
end
