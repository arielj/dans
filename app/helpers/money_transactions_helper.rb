# frozen_string_literal: true

module MoneyTransactionsHelper
  def transactions_totals(people, general)
    totals = {
      persons_in: people.total_in,
      persons_out: people.total_out,
      general_in: general.total_in,
      general_out: general.total_out
    }

    totals[:in] = totals[:persons_in] + totals[:general_in]
    totals[:out] = totals[:persons_out] + totals[:general_out]
    totals[:total] = totals[:in] - totals[:out]
    totals
  end

  def generate_pdf(items)
    header_data = [[items.first.person.to_label, items.first.receipt.to_s, I18n.l(Date.today, format: :short)]]

    table_header = %w[Fecha Descripción Monto]
    table_content = items.map { |item| [I18n.l(item.created_at.to_date, format: :short), item.description.to_s, "$#{item.amount}"] }
    table_footer = ['', '', "Total: #{items.map(&:amount).sum}"]

    footer_data = [[Setting.fetch(:name, ''), '', '.............']]

    Prawn::Document.new(page_size: 'A6', page_layout: :landscape) do
      table(header_data) do
        cells.borders = []
      end

      move_down font.height * 2

      table([table_header] + table_content + [table_footer]) do
        cells.borders = []
      end

      move_down font.height * 2

      table(footer_data) do
        cells.borders = []
      end
    end.render
  end
end
