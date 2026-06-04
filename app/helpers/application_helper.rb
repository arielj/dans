# frozen_string_literal: true

module ApplicationHelper
  def page_title(value)
    content_for :page_title do
      value
    end
  end

  def render_flash_message(key)
    aux = case key
          when 'notice', :notice then :success
          when 'alert', :alert then :error
          else key
          end

    content_tag 'div', class: "toast toast-#{aux}" do
      concat tag.button(class: 'btn btn-clear float-right')
      concat flash[key]
    end
  end

  def m(mon)
    if mon.is_a?(Money)
      mon.format
    elsif mon.is_a?(Float)
      number_to_currency(mon)
    end
  end

  def amounts_for_form_metadata(installment)
    base_amount = installment.to_pay(add_debit_extra: false, ignore_recharge: :all)
    amount_with_first_surcharge = installment.to_pay(add_debit_extra: false, ignore_recharge: :second)
    amount_with_second_surcharge = installment.to_pay(add_debit_extra: false, ignore_recharge: false)

    {
      base_amount: base_amount.to_f,
      first_surcharge_amount: (amount_with_first_surcharge - base_amount).to_f,
      second_surcharge_amount: (amount_with_second_surcharge - base_amount).to_f,
      debit_extra: DEBIT_EXTRA.to_f
    }
  end
end
