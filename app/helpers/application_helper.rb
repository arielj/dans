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

  # use a helper methods instead of a partial, it's faster
  def payments_detail(payable)
    return if payable.payments.empty?

    content_tag 'ul' do
      payable.payments.each do |p|
        concat(content_tag('li') do
          concat tag.i(class: 'fa fa-calendar', title: l(p.created_at))
          concat " $#{p.amount} "
          concat content_tag('span', '(*)', title: p.description) if p.description.present?
        end)
      end
    end
  end

  def installment_amount(ins)
    s = "$#{ins.amount}"
    if ins.paid_with_interests?
      s += " (+#{ins.amount_paid - ins.amount})"
    elsif (r = ins.get_recharge).positive?
      s += " (+#{r})"
    end
    s
  end
end
