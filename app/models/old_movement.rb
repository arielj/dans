# typed: true
# frozen_string_literal: true

class OldMovement < OldRecord
  self.table_name = :movements

  def to_new
    puts "Movement #{id}"

    MoneyTransaction.create! amount_cents: amount, done: done, created_at: date,
                             daily_cash_closer: daily_cash_closer, description: description
  end
end
