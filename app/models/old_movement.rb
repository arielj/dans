# typed: true
# frozen_string_literal: true

class OldMovement < OldRecord
  self.table_name = :movements

  def to_new
    m = MoneyTransaction.new amount_cents: amount, done: done, created_at: date,
                             daily_cash_closer: daily_cash_closer, description: description

    puts m.errors.full_messages if m.invalid?

    m.save
  end
end
