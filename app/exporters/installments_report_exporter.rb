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

    sheets = []

    headers = ['NOMBRE', 'AÑO', 'MES', 'CLASES', 'ESTADO', 'MEDIO DE PAGO', 'MONTO BASE', 'DESC. FAMILIAR %', 'DECS. MATERIAS %', 'DESC. PROFE %', 'DESC. MANUAL %', 'DESC. TOTAL %', 'DESCUENTO', 'INTERESES', 'RECARGO DÉBITO', 'MONTO FINAL', 'VALOR MATERIA']

    Klass.find(klass_ids).each do |klass|
      # excel sheets can't have a name longer than 30 characters
      sheet_name = klass.name.gsub(/[\[\]\:\*\?\/\\]/, '').truncate(30)

      # excel sheets can't repeat names, which can happen because of the previous truncation
      x = 1
      while sheets.include?(sheet_name)
        x += 1
        sheet_name[-1] = x.to_s
      end
      sheets << sheet_name

      worksheet = workbook.add_worksheet(sheet_name)
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

        amount = ins.waiting? ? ins.amount_with_discount : ins.amount_paid
        amount_without_debit = ins.paid_with_debit? || ins.paid_with_interests_and_debit? ? amount - DEBIT_EXTRA : amount
        interests = Money.new(0)
        if ins.membership_amounts && (ins.paid_with_interests? || ins.paid_with_interests_and_debit?)
          interests = amount_without_debit - Money.new(ins.membership_amounts[:subtotal].gsub(",","").to_i) + Money.new(ins.membership_amounts[:totalDiscount].gsub(",","").to_i)
        end

        row = [
          ins.person.to_label,
          year,
          month_name,
          ins.klasses.map(&:name).join(' ; '),
          installment_status(ins),
          installment_payment_method(ins),
          (ins.membership_amounts ? ins.membership_amounts[:subtotal] : "").to_f,
          ins.membership_amounts ? ins.membership_amounts[:familyDiscountPer] : "",
          ins.membership_amounts ? ins.membership_amounts[:klassesDiscountPer] : "",
          ins.membership_amounts ? ins.membership_amounts[:teacherDiscountPer] : "",
          ins.membership_amounts ? ins.membership_amounts[:manualDiscountPer] : "",
          ins.membership_amounts ? ins.membership_amounts[:totalDiscountPer] : "",
          (ins.membership_amounts ? ins.membership_amounts[:totalDiscount] : "").to_f,
          (interests.to_s).to_f,
          (ins.paid_with_debit? || ins.paid_with_interests_and_debit? ? DEBIT_EXTRA.to_s : "0,00").to_f,
          (amount.to_s).to_f,
          (ins.membership_amounts ? ins.membership_amounts[:feesPerKlass][klass.id] : "").to_f,
        ]

        worksheet.append_row(row)
      end
    end

    workbook.close
    filepath
  end

  def self.installment_status(ins)
    payed = !ins.waiting?
    incomplete_payment = !payed && ins.payments.any?

    if payed
      "Pagado"
    elsif incomplete_payment
      "Pagado (parte)"
    else
      "No pagado"
    end
  end

  def self.installment_payment_method(ins)
    return "Efectivo" if ins.paid? || ins.paid_with_interests?
    return "Débito" if ins.paid_with_debit? || ins.paid_with_interests_and_debit?
    
    "-"
  end
end
