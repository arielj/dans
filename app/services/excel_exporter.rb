# typed: true
# frozen_string_literal: true

require 'fast_excel'

class ExcelExporter
  def self.to_xls(collection)
    filename = "export-#{collection.klass}-#{Time.now}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    worksheet = workbook.add_worksheet('Export')

    worksheet.append_row(headers_for(collection.klass))
    collection.each do |item|
      worksheet.append_row(fields_for(item))
    end
    workbook.close

    filepath
  end

  def self.headers_for(cls)
    case cls.to_s
    when 'Room' then ['Nombre']
    when 'Person' then ['Nombre', 'Apellido', 'DNI']
    when 'Package' then ['Nombre']
    when 'Klass' then ['Nombre', 'Activa']
    else []
    end
  end

  def self.fields_for(item)
    case item.class.to_s
    when 'Room' then [item.name]
    when 'Person' then [item.name, item.lastname, item.dni]
    when 'Package' then [item.name]
    when 'Klass' then [item.name, (item.active? ? 'Si' : 'No')]
    else []
    end
  end
end
