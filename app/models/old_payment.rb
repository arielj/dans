# frozen_string_literal: true

class OldPayment < OldRecord
  self.table_name = :payments

  def to_new
    puts "Payment #{id}"

    if amount&.zero?
      puts 'monto 0'
    else
      payable = if installment_id.present?
                  Installment.where(id: installment_id).first
                elsif liability_id.present?
                  Debt.where(id: liability_id).first
                end

      if (installment_id.present? || liability_id.present?) && !payable
        puts 'no installment/debt'
      else
        MoneyTransaction.create! amount_cents: amount, payable: payable, person_id: user_id,
                                 description: description, done: done, created_at: date,
                                 daily_cash_closer: daily_cash_closer, receipt: receipt_number
      end
    end
  end
end
