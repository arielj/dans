require "application_system_test_case"

class AddingMembershipsTest < ApplicationSystemTestCase
  test 'can calculate price with and without discount' do
    sign_in admins(:operator)

    student = FactoryBot.create(:student)
    room = FactoryBot.create(:room)
    klass1 = FactoryBot.build(:klass, fixed_fee: 0)
    klass1.schedules.build(from_time: '12:30', to_time: '13:30', room: room, day: 1)
    klass1.schedules.build(from_time: '14:30', to_time: '15:30', room: room, day: 2)
    klass1.save!

    klass2 = FactoryBot.build(:klass, fixed_fee: 110, fixed_alt_fee: 70)
    klass2.schedules.build(from_time: '15:30', to_time: '13:30', room: room, day: 3)
    klass2.schedules.build(from_time: '16:30', to_time: '16:30', room: room, day: 4)
    klass2.save!

    visit edit_person_path(student)

    click_link 'Cuotas'

    click_on 'Agregar paquete'

    within '#new_membership' do
      # pick classes with fee by class
      click_checkbox("#membership_schedule_ids_#{klass2.schedules.second.id}")
      # assert_text 'Precio clases fijas: $70,00'
      assert_text 'Total: $70,00'

      # pick 2nd class for klass2 to use full price
      click_checkbox("#membership_schedule_ids_#{klass2.schedules.first.id}")
      assert_text 'Total: $110,00'

      # unselect 2nd class and use regular student fee
      click_checkbox("#membership_schedule_ids_#{klass2.schedules.first.id}")
      assert_text 'Total: $70,00 (efectivo) o $5070,00 (débito)'

      # set discount
      click_checkbox("#membership_use_manual_discount")
      find('#membership_manual_discount').set('10%')
      assert_text 'Total: $63,00 (efectivo) o $5063,00 (débito)'

      click_button 'Guardar paquete'
    end

    m = student.memberships.last
    assert_equal '5063,00', m.amount
    assert_equal '63,00', m.amount_with_discount
  end
end
