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
          concat(link_to(new_payment_installment_path(ins), remote: true, title: t('add.payment')) do
            tag(:i, class: 'fa fa-plus')
          end)
        end
      end)
      concat(content_tag(:td) do
        concat(link_to(ins, method: :delete, data: { confirm: '¿Eliminar cuota?' }, title: 'Eliminar cuota') do
          concat(tag(:i, class: 'fa fa-trash'))
        end)
      end)
    end
  end
end
