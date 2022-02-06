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

    klass2 = FactoryBot.build(:klass, fixed_fee: 110, fixed_fee_with_discount: 100, fixed_alt_fee: 70, fixed_alt_fee_with_discount: 60, non_regular_fee: 120, non_regular_fee_with_discount: 105, non_regular_alt_fee: 115, non_regular_alt_fee_with_discount: 110)
    klass2.schedules.build(from_time: '15:30', to_time: '13:30', room: room, day: 3)
    klass2.schedules.build(from_time: '16:30', to_time: '16:30', room: room, day: 4)
    klass2.save!

    visit edit_person_path(student)

    click_link 'Cuotas'

    click_on 'Agregar paquete'

    within '#new_membership' do
      # pick classes with fee by hour
      click_checkbox("#membership_schedule_ids_#{klass1.schedules.first.id}")
      assert_text 'Precio por 1hs: $100,00 (o $90,00)'

      click_checkbox("#membership_schedule_ids_#{klass1.schedules.second.id}")
      assert_text 'Precio por 2hs: $190,00 (o $170,00)'

      # pick classes with fee by class
      click_checkbox("#membership_schedule_ids_#{klass2.schedules.second.id}")
      assert_text 'Precio clases fijas: $70,00 (o $60,00)'
      assert_text 'Total: $260,00 (o $230,00)'

      # pick non-regular student fees
      click_checkbox("#membership_use_non_regular_fee")
      assert_text 'Total: $305,00 (o $280,00)'

      # pick 2nd class for klass2 to use full price
      click_checkbox("#membership_schedule_ids_#{klass2.schedules.first.id}")
      assert_text 'Total: $310,00 (o $275,00)'

      # unselect 2nd class and use regular student fee
      click_checkbox("#membership_use_non_regular_fee")
      click_checkbox("#membership_schedule_ids_#{klass2.schedules.first.id}")

      # set discount
      click_checkbox("#membership_use_manual_discount")
      find('#membership_manual_discount').set('10%')
      assert_text 'Total: $234,00 (o $207,00)'

      click_button 'Guardar paquete'
    end

    m = student.memberships.last
    # 190 (by hours) + 70 (1 class) - 10%
    assert_equal '234,00', m.amount
    # 170 (by hours) + 60 (1 class) - 10%
    assert_equal '207,00', m.amount_with_discount
  end
end
