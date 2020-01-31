# frozen_string_literal: true

module DebtsHelper
  def debt_tr(debt)
    content_tag(:tr, id: "debt_#{debt.id}") do
      concat(content_tag(:td, I18n.l(debt.created_at, format: :date), title: l(debt.created_at)))
      concat(content_tag(:td, debt.description))
      concat(content_tag(:td, "$#{debt.amount}"))
      concat(content_tag(:td, I18n.t("payment_status.#{debt.status}")))
      concat(content_tag(:td, class: 'actions') do
        concat(payments_detail(debt))
        if debt.to_pay.positive?
          concat(link_to(add_payment_debt_path(debt), remote: true, title: t('add.payment')) do
            content_tag(:i, '', class: 'fa fa-plus')
          end)
        end
      end)
    end
  end
end
