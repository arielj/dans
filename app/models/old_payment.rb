class OldPayment < OldRecord
  self.table_name = :payments

  def to_new
    payable = if installment_id.present?
      Installment.find(installment_id)
    elsif liability_id.present?
      Debt.find(liability_id)
    end

    m = MoneyTransaction.new amount_cents: amount, payable: payable, person_id: user_id,
      description: description, done: done, created_at: date,
      daily_cash_closer: daily_cash_closer, receipt: receipt_number
    if m.invalid?
      puts m.errors.full_messages
    end
    m.save
  end
end
