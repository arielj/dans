# frozen_string_literal: true

module InstallmentsHelper
  def installment_tr(ins)
    content_tag(:tr, class: 'installment', id: "installment_#{ins.id}") do
      concat(content_tag(:td, ins.year))
      concat(content_tag(:td) do
        concat(ins.month_name)
        concat(installment_memberships_tooltip(ins))
      end)
      concat(content_tag(:td, installment_amount(ins)))
      concat(content_tag(:td, t("payment_status.#{ins.status}"), class: :payments))
      concat(content_tag(:td) do
        concat(payments_detail(ins))
        if ins.waiting?
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

  def installment_amount(ins, ignore_recharge: :none, add_debit_extra: false)
    a = ins.amount_with_discount
    a += DEBIT_EXTRA if add_debit_extra
    s = "$#{a}"
    if ins.paid_with_interests?
      s += " (+#{ins.amount_paid - a})"
    elsif (r = ins.get_recharge(ignore: ignore_recharge)).positive?
      s += " (+#{r})"
    end
    s
  end

  def installment_to_pay(ins, ignore_recharge: :none, add_debit_extra: false)
    a = ins.to_pay(ignore_recharge: ignore_recharge)
    "$#{a}"
  end

  def installment_paid_amount(ins, ignore_recharge: :none)
    if ins.paid_with_debit? || ins.paid_with_interests_and_debit?
      "$#{ins.amount_with_discount + DEBIT_EXTRA}"
    elsif ins.paid? || ins.paid_with_interests?
      "$#{ins.amount_with_discount}"
    else
      installment_amount(ins, ignore_recharge: ignore_recharge)
    end
  end

  def installment_memberships_tooltip(ins)
    content_tag 'ul', class: 'memberships-tooltip' do
      ins.get_klasses.each do |klass|
        concat(content_tag('li', klass.name))
      end
    end
  end

  def installment_status(ins)
    payed = !ins.waiting?
    incomplete_payment = !payed && ins.payments.any?

    if payed
      "Pagado"
    elsif incomplete_payment
      "Pagado (parte)"
    else
      "No pagado"
    end
  end

  def installment_payment_method(ins)
    return "Efectivo" if ins.paid? || ins.paid_with_interests?
    return "Débito" if ins.paid_with_debit? || ins.paid_with_interests_and_debit?
    
    "-"
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
