require "application_system_test_case"

class AddingMembershipsTest < ApplicationSystemTestCase
  test 'can calculate price with and without discount' do
    sign_in admins(:operator)

    Setting.set_hours_fees(1, [100, 90])
    Setting.set_hours_fees(2, [190, 170])

    student = FactoryBot.create(:student)
    room = FactoryBot.create(:room)
    klass1 = FactoryBot.build(:klass, fixed_fee: 0, non_regular_fee: 0)
    klass1.schedules.build(from_time: '12:30', to_time: '13:30', room: room, day: 1)
    klass1.schedules.build(from_time: '14:30', to_time: '15:30', room: room, day: 2)
    klass1.save!

    klass2 = FactoryBot.build(:klass, fixed_fee: 110, non_regular_fee: 120, fixed_fee_with_discount: 100, non_regular_fee_with_discount: 105)
    klass2.schedules.build(from_time: '15:30', to_time: '13:30', room: room, day: 3)
    klass2.schedules.build(from_time: '16:30', to_time: '16:30', room: room, day: 4)
    klass2.save!

    visit edit_person_path(student)

    click_link 'Cuotas'

    click_on 'Agregar paquete'

    within '#new_membership' do
      click_checkbox("#membership_schedule_ids_#{klass1.schedules.first.id}")
      assert_text 'Precio por 1hs: $100,00 (o $90,00)'

      click_checkbox("#membership_schedule_ids_#{klass1.schedules.second.id}")
      assert_text 'Precio por 2hs: $190,00 (o $170,00)'

      click_checkbox("#membership_schedule_ids_#{klass2.schedules.second.id}")
      assert_text 'Precio clases fijas: $110,00 (o $100,00)'

      assert_text 'Total: $300,00 (o $270,00)'

      click_checkbox("#membership_use_manual_discount")
      fill_in :membership_manual_discount, with: '10%'

      assert_text 'Total: $270,00 (o $243,00)'

      click_button 'Guardar paquete'
    end

    m = student.memberships.last
    # 190 + 110 - 10%
    assert_equal '270,00', m.amount
    assert_equal '243,00', m.amount_with_discount
  end
end
