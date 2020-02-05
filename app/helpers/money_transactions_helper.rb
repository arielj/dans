# typed: false
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
    header_data = [[
      { content: items.first.person.to_label, width: 160 },
      { content: "Nº#{items.first.receipt}", align: :center, width: 60 },
      { content: I18n.l(DateTime.current.to_date, format: :receipt), align: :right, width: 160 }
    ]]

    table_header = [
      I18n.t(:date, scope: :receipts).upcase,
      I18n.t(:description, scope: :receipts).upcase,
      { content: I18n.t(:amount, scope: :receipts).upcase, align: :center }
    ]

    table_content = items.map do |item|
      [
        { content: I18n.l(item.created_at.to_date, format: :receipt_item), width: 80 },
        item.description.to_s,
        { content: "$#{item.amount}", align: :right }
      ]
    end
    table_footer = ['', { content: "Total: $#{items.map(&:amount).sum}", align: :right, colspan: 2 }]
    table_data = [table_header] + table_content + [table_footer]

    footer_data = [[Setting.fetch(:name, ''), '', { content: '.......................', align: :center }]]

    Prawn::Document.new(page_size: 'A6', page_layout: :landscape, margin: 15) do
      table(header_data, width: 380, position: :center) do
        cells.borders = []
      end

      move_down font.height * 1.5

      table(table_data, width: 380, position: :center) do
        cells.borders = [:bottom]
        row(0).font_style = :bold
        row(0).border_width = 2
        row(-1).borders = []
        row(-1).font_style = :bold
      end

      move_cursor_to 30

      table(footer_data, width: 380, position: :center) do
        cells.borders = []
      end
    end.render
  end
end
