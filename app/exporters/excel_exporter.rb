# typed: true
# frozen_string_literal: true

require 'fast_excel'

class ExcelExporter
  def self.to_xls(collection)
    filename = "export-#{collection.klass.model_name.human(count: 100)}-#{Time.now.to_i}.xlsx"
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
    when 'Room' then %w[Nombre]
    when 'Person' then %w[Nombre DNI]
    when 'Package' then %w[Nombre]
    when 'Klass' then %w[Nombre Activa]
    else []
    end
  end

  def self.fields_for(item)
    case item.class.to_s
    when 'Room' then [item.name]
    when 'Person' then [item.full_name, item.dni]
    when 'Package' then [item.name]
    when 'Klass' then [item.name, (item.active? ? 'Si' : 'No')]
    else []
    end
  end
end
