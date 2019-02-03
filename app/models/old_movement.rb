class OldMovement < OldRecord
  self.table_name = :movements

  def to_new
    m = MoneyTransaction.new amount_cents: amount, done: done, created_at: date,
      daily_cash_closer: daily_cash_closer, description: description
    if m.invalid?
      puts m.errors.full_messages
    end
    m.save
  end
end
