# frozen_string_literal: true

module InstallmentsHelper
  def installment_tr(ins)
    content_tag(:tr, class: 'installment', id: "installment_#{ins.id}") do
      concat(content_tag(:td, ins.year))
      concat(content_tag(:td, ins.month_name))
      concat(content_tag(:td, installment_amount(ins)))
      concat(content_tag(:td, t("payment_status.#{ins.status}"), class: :payments))
      concat(content_tag(:td) do
        concat(payments_detail(ins))
        if ins.to_pay.positive?
          concat(link_to(new_installment_payment_path(ins), remote: true, title: t('add.payment')) do
            tag(:i, class: 'fa fa-plus')
          end)
        end
      end)
      concat(content_tag(:td) do
        concat(link_to(edit_installment_path(ins), title: 'Editar cuota', remote: true) do
          concat(content_tag(:i, '', class: 'fa fa-pencil'))
        end)
        concat(' ')
        concat(link_to(ins, method: :delete, data: { confirm: '¿Eliminar cuota?' }, title: 'Eliminar cuota') do
          concat(content_tag(:i, '', class: 'fa fa-trash'))
        end)
      end)
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

  # use a helper methods instead of a partial, it's faster
  def payments_detail(payable)
    return if payable.payments.empty?

    content_tag 'ul', class: 'payment-details' do
      payable.payments.each do |p|
        concat(content_tag('li') do
          concat(tag.i(class: 'fa fa-calendar', title: I18n.l(p.created_at)))
          concat(" $#{p.amount} ")

          if p.description.present? && p.description != 'cuota'
            concat(content_tag('span', '(*)', title: p.description))
          end

          concat(
            link_to(edit_money_transaction_path(p), class: 'edit', remote: true, id: "edit_payment_#{p.id}") do
              content_tag(:i, '', class: 'fa fa-edit')
            end
          )
        end)
      end
    end
  end
end
