# frozen_string_literal: true

require "application_system_test_case"
 
class SettingsTest < ApplicationSystemTestCase
  test 'adds fees per hours' do
    Setting.set('hour_fees', {})

    sign_in admins(:operator)

    Setting.set_hours_fees(0.5, [50, 45])

    visit settings_path

    click_on 'Agregar precio'

    within '#add_price_form' do
      fill_in 'Horas', with: '1'
      fill_in 'Valor (sin descuento)', with: '100'
      fill_in 'Valor (con descuento)', with: '90'
      click_button 'Agregar'
    end

    tr = find('tr[data-hours="1"]')

    assert_equal '1', tr.find('td:nth-child(1)').text
    assert_equal '100', tr.find('td:nth-child(2) input').value
    assert_equal '90', tr.find('td:nth-child(3) input').value

    click_button 'Guardar opciones'

    assert_text 'Configuración guardada'

    assert_equal '50', Setting.get_hours_fee(0.5, with_discount: false)
    assert_equal '45', Setting.get_hours_fee(0.5, with_discount: true)
    assert_equal '100', Setting.get_hours_fee(1, with_discount: false)
    assert_equal '90', Setting.get_hours_fee(1, with_discount: true)
  end
end
