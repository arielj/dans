# typed: true
# frozen_string_literal: true

require 'fast_excel'

class StudentsHoursReportExporter
  def self.to_xls(year, klasses, students, data, stats)
    filename = "export-alumos-por-hora-#{year}-#{Time.now}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    worksheet = workbook.add_worksheet('Export')

    headers = ['Alumno/a'] + klasses.map(&:name) + ['Total']
    worksheet.append_row(headers)

    students.each do |std|
      row = [std.to_label]
      row += klasses.map { |kls| data.dig(std.id, kls.id) || 0 }
      row << (data.dig(std.id) || {}).values.sum

      worksheet.append_row(row)
    end

    worksheet = workbook.add_worksheet('Totales por horas')

    headers = ['Horas', 'Cantidad de alumnos']
    worksheet.append_row(headers)

    stats.keys.sort { |x, y| x.to_f <=> y.to_f }.each do |hours|
      worksheet.append_row([hours, stats[hours]])
    end

    workbook.close
    filepath
  end
end
