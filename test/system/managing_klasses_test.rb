# frozen_string_literal: true

require "application_system_test_case"
 
class ManagingKlassesTest < ApplicationSystemTestCase
  test 'can add teachers' do
    sign_in admins(:operator)

    teacher1 = FactoryBot.create(:teacher, name: 'juan', lastname: 'perez')
    teacher2 = FactoryBot.create(:teacher, name: 'juan', lastname: 'gomez')

    visit root_path
    click_on 'Clases'
    click_on 'Agregar clase'

    fill_in 'Nombre', with: 'Clase'
    fill_in 'klass_fixed_fee', with: '100,00'
    click_on 'Agregar Horario'

    assert_selector 'label', text: 'Horario desde'
    fill_in 'Horario desde', with: '16:00'
    fill_in 'Horario hasta', with: '18:00'
    find('[id$=_day]').select('lunes')

    click_on 'Asignar profesores/as'

    within '.modal' do
      assert_selector 'label', text: 'Juan Perez'
      assert_selector 'label', text: 'Juan Gomez'

      find("#teacher_ids_#{teacher1.id}").sibling('*').click

      click_on 'Aceptar'
    end

    within '#teachers' do
      assert_selector '.teacher', text: 'Juan Perez'
    end

    click_on 'Crear clase'

    assert_match(/creada/i, page.text)

    kls = Klass.last
    assert_equal kls.name, 'Clase'
    assert_equal kls.fixed_fee, Money.new(100_00)
    assert_equal kls.teachers.size, 1
    assert_equal kls.teacher_ids, [teacher1.id]
  end
end
