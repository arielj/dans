# frozen_string_literal: true

require 'fast_excel'

class DailyCashReportExporter
  def self.to_xls(date, people_transactions, general_transactios, totals)
    filename = "export-caja-diaria-#{date}-#{Time.now.to_i}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    worksheet = workbook.add_worksheet('Caja Diaria')

    headers = %w[Entradas Salidas Detalle Persona]
    worksheet.append_row(headers)

    ins = Money.new(0)
    outs = Money.new(0)
    people_transactions.each do |payment|
      row = []
      if payment.done
        outs += payment.amount
        row += ['', payment.amount]
      else
        ins += payment.amount
        row += [payment.amount, '']
      end
      row << payment.description
      row << (payment.person ? payment.person.to_label : '')

      worksheet.append_row(row)
    end

    worksheet.append_row([])
    worksheet.append_row([ins, outs])

    worksheet.append_row([])
    worksheet.append_row([])

    headers = %w[Entradas Salidas Detalle]
    worksheet.append_row(headers)

    ins = Money.new(0)
    outs = Money.new(0)
    general_transactios.each do |payment|
      row = []
      if payment.done
        outs += payment.amount
        row += ['', payment.amount]
      else
        ins += payment.amount
        row += [payment.amount, '']
      end
      row << payment.description

      worksheet.append_row(row)
    end

    worksheet.append_row([])
    worksheet.append_row([ins, outs])

    worksheet.append_row([])
    worksheet.append_row([])
    headers = %w[Entradas Salidas Total]
    worksheet.append_row(headers)
    worksheet.append_row([totals[:in], totals[:out], totals[:total]])

    workbook.close
    filepath
  end
end
