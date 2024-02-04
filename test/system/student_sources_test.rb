require "application_system_test_case"
 
class StudentSourcesTest < ApplicationSystemTestCase
  setup do
    sign_in admins(:operator)
  end

  test 'can add custom sources' do
    student = FactoryBot.create(:student)
    assert_empty Person.students.where(source: 'Instagram')

    visit edit_person_path(student)

    fill_in 'Fuente', with: 'Instagram'

    click_button 'Guardar'

    refute_empty Person.students.where(source: 'Instagram')
    
    student.reload
    assert_equal 'Instagram', student.source
  end

  test 'shows existing sources as a datalist' do
    FactoryBot.create(:student, source: 'Instagram')
    FactoryBot.create(:student, source: 'Otra alumna')

    student = FactoryBot.create(:student)
    
    visit edit_person_path(student)

    fill_in 'Fuente', with: 'Instagram'

    assert_selector '#person_source[list="sources"]'

    within 'datalist#sources', visible: false do
      assert_selector 'option', text: 'Instagram', visible: false
      assert_selector 'option', text: 'Otra alumna', visible: false
    end
  end
end
