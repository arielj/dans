# typed: true
# frozen_string_literal: true

require 'fast_excel'

class ExtraKlassesStudentsReportExporter
  def self.to_xls(year, klasses, data, totals)
    filename = "export-alumnos-clases-extras-#{year}-#{Time.now.to_i}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    worksheet = workbook.add_worksheet('Export')

    headers = ['Clase'] + klasses.map(&:name) + ['Total']
    worksheet.append_row(headers)

    row = ['Regulares']
    klasses.each do |kls|
      row << "#{data[kls.id][:regular]} / $#{totals[kls.id][:regular]}"
    end
    row << "$#{totals.map { |_k, v| v[:regular] }.sum}"
    worksheet.append_row(row)

    row = ['No Regulares']
    klasses.each do |kls|
      row << "#{data[kls.id][:non_regular]} / $#{totals[kls.id][:non_regular]}"
    end
    row << "$#{totals.map { |_k, v| v[:non_regular] }.sum}"
    worksheet.append_row(row)

    row = ['']
    klasses.each do |kls|
      row << "$#{totals[kls.id].values.sum}"
    end
    worksheet.append_row(row)

    workbook.close
    filepath
  end
end
