# typed: true
# frozen_string_literal: true

class OldDebt < OldRecord
  self.table_name = 'liabilities'

  def to_new
    d = Debt.new id: id, status: status, amount_cents: T.must(amount) * 100,
                 person_id: user_id, description: description, created_at: date

    puts d.errors.full_messages if d.invalid?

    d.save
  end
end
