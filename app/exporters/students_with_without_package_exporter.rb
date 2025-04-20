# frozen_string_literal: true

require 'fast_excel'

class StudentsWithWithoutPackageExporter
  def self.to_xls(year, klasses, data, stats)
    filename = "export-alumnos-con-sin-paquete-#{year}-#{Time.now.to_i}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    worksheet = workbook.add_worksheet('Export')

    headers = ['Clase', 'Con Paquete', 'Sin Paquete', 'Total']
    worksheet.append_row(headers)

    klasses.each do |klass|
      kdata = data[klass.id]
      row = [klass.name, kdata[:with], kdata[:without], kdata[:with] + kdata[:without]]
      worksheet.append_row(row)
    end

    totals_row = ['Total', stats[:with], stats[:without], stats[:total]]
    worksheet.append_row(totals_row)

    workbook.close
    filepath
  end
end
