desc 'Excel con más info'
task report: :environment do
  filepath = Rails.root.join('tmp', "export-#{Time.now}.xlsx")
  workbook = FastExcel.open(filepath, constant_memory: true)

  worksheet = workbook.add_worksheet('Export')

  headers = ['Persona', 'id_per', 'id_cuota', 'estado', 'medio de pago', 'con intereses?', 'monto pagado', 'recargo débito', 'monto pagado (sin recargo débito)', 'intereses', 'valor ingresado manual?', 'valor base', 'descuento %', 'descuento', 'montos']
  worksheet.append_row(headers)

  Installment.includes(:person, :membership, :payments).where(year: 2026, month: :april).order("people.name ASC").each do |ins|
    next if ins.person.inactive?

    installment_id = ins.id
    amount = !ins.waiting? ? ins.amount_paid : ins.amount_with_discount
    amounts = ins.membership.amounts
    custom_amount = ins.membership.use_custom_amount ? ins.membership.amount_with_discount : nil
    membersip_amount = ins.membership.use_custom_amount ? custom_amount : Money.new(amounts[:subtotal].gsub(",","").to_i)
    person = ins.person

    total_discount_per = 0
    total_discount_val = "0,00"

    if !custom_amount
      total_discount_per = amounts[:totalDiscountPer]
      total_discount_val = amounts[:totalDiscount]
    end

    payment_method = ""
    with_interests = false
    payed = false

    case ins.status
    when "paid"
      payment_method = "Contado"
      payed = true
    when "paid_with_debit"
      payment_method = "Débito"
      payed = true
    when "paid_with_interests"
      payment_method = "Contado"
      with_interests = true
      payed = true
    when "paid_with_interests_and_debit"
      payment_method = "Débito"
      with_interests = true
      payed = true
    end

    incomplete_payment = !payed && ins.payments.any?
    amount = ins.amount_paid if incomplete_payment

    status = if payed
      "Pagado"
    elsif incomplete_payment
      "Pagado (parte)"
    else
      "No pagado"
    end

    debit_extra = (ins.paid_with_debit? or ins.paid_with_interests_and_debit?) ? DEBIT_EXTRA : Money.new(0)

    amount_without_debit_extra = amount - debit_extra

    surcharge = with_interests ? amount_without_debit_extra - (membersip_amount - Money.new(total_discount_val.gsub(",","").to_i)) : Money.new(0)

    row = [person.to_label, person.id, ins.id, status, payment_method, with_interests ? "si" : "no", amount.to_f, debit_extra.to_f, amount_without_debit_extra.to_f, surcharge.to_f, custom_amount ? "si" : "no", custom_amount ? custom_amount.to_f : amounts[:subtotal].to_f, total_discount_per, total_discount_val, amounts]
    worksheet.append_row(row)
  end

  workbook.close
  filepath
end
