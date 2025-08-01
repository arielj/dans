# frozen_string_literal: true

require 'fast_excel'

class InstallmentsReportExporter
  def self.to_xls(year:, month:, klass_id: nil, state:, include_inactive_users:, only_with_recharge:)
    month_num = Installment.months[month] + 1
    month_name = I18n.t('date.month_names')[month_num]

    filename = "export-clases-#{year}-#{month_name}-#{Time.now.to_i}.xlsx"
    filepath = Rails.root.join('tmp', filename)
    workbook = FastExcel.open(filepath, constant_memory: true)

    klass_ids = klass_id.present? ? [klass_id] : Klass.active.pluck(:id)

    Klass.find(klass_ids).each do |klass|
      worksheet = workbook.add_worksheet(klass.name.gsub(/[\[\]\:\*\?\/\\]/, '').truncate(30))

      headers = ['NOMBRE', 'AÑO', 'MES', 'CLASES', 'CUOTA']
      worksheet.append_row(headers)

      count = 0
      total = 0

      installments = klass.installments.where(year: year, month: month).includes(:person)
      installments =
        case state
        when 'paid' then installments.not_waiting
        when 'waiting' then installments.waiting
        else installments
        end
      installments = installments.for_active_users unless include_inactive_users
      installments = installments.with_recharge if only_with_recharge

      installments.includes(:membership).uniq.each do |ins|
        count += 1

        klasses = ins.membership_klasses
        klass_names = klasses.map(&:name).join(', ')
        klass_ids = klasses.map(&:id)
        single_klass = klass_ids.uniq.length == 1

        total_amount = ins.amount.to_f
        single_klass_amount = total_amount
        unless single_klass
          single_klass_amount = klass.fixed_fee
          
          schedules_for_klass = klass_ids.select{ |id| id == klass.id }
          if schedules_for_klass.length == 1 && klass.fixed_alt_fee > 0
            single_klass_amount = klass.fixed_alt_fee
          end
        end

        if ins.membership.apply_discounts && klass.discount.present?
          single_klass_amount = single_klass_amount * (100 - klass.discount.to_f)/100
        end

        single_klass_amount = single_klass_amount.to_f

        total += single_klass_amount

        row = [ins.person.to_label, year, month_name, klass_names, total_amount, 1, single_klass ? "Sin Paquete" : "Paquete", single_klass_amount]
        worksheet.append_row(row)
      end

      row = ["", "", "", "", "", count, "", total]
      worksheet.append_row(row)
    end

    workbook.close
    filepath
  end
end
