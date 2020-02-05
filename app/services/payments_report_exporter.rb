# typed: true
# frozen_string_literal: true

require 'fast_excel'

class PaymentsReportExporter
  def self.to_xls(date_from, date_to, payments)
    filename = "export-pagos-#{date_from}-#{date_to}-#{Time.now.to_i}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    worksheet = workbook.add_worksheet('Export')

    hs = [
      MoneyTransaction.human_attribute_name(:person),
      MoneyTransaction.human_attribute_name(:created_at),
      MoneyTransaction.human_attribute_name(:amount),
      MoneyTransaction.human_attribute_name(:description),
      MoneyTransaction.human_attribute_name(:receipt)
    ]

    worksheet.append_row(hs)

    payments.each do |pay|
      row = [
        pay.person.to_label,
        I18n.l(pay.created_at),
        pay.amount,
        pay.description,
        pay.receipt
      ]

      worksheet.append_row(row)
    end

    workbook.close
    filepath
  end
end
