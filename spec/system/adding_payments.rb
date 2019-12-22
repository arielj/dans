# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Adding payments', type: :system, js: true do
  before do
    driven_by :selenium, using: :headless_chrome
  end

  it 'can ignore the recharge' do
    log_in

    student = FactoryBot.create(:student)
    klass = FactoryBot.create(:klass_with_schedules)
    student.memberships.create(schedules: klass.schedules, amount: 50_000)
    Setting.set(:recharge_after_day, 2)
    Setting.set(:recharge_value, '10%')
    Setting.set(:month_recharge_value, '20%')

    visit edit_person_path(student)

    click_link 'Cuotas'

    expect(page).to have_selector "#installment_#{student.installments.first.id}"

    within "#installment_#{student.installments.first.id}" do
      click_link 'Agregar pago'
    end

    expect(page).to have_selector '.modal #add_installment_payment'

    within '.modal #add_installment_payment' do
      expect(page).to have_text 'Restante: $600,00'

      expect(page).to have_text 'Ignorar recargo a mes vencido'

      find('#ignore_month_recharge_label').click

      expect(page).to have_text 'Restante: $550,00'

      expect(page).to have_text 'Ignorar recargo por fecha'

      find('#ignore_recharge_label').click

      expect(page).to have_text 'Restante: $500,00'

      click_button 'Guardar'
    end

    sleep(1)

    within "#installment_#{student.installments.first.id}" do
      expect(page).to have_text 'Pagado'
    end
  end
end
