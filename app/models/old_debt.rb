# frozen_string_literal: true

class OldDebt < OldRecord
  self.table_name = 'liabilities'

  def to_new
    puts "Debt #{id}"

    Debt.create! id: id, status: status, amount_cents: amount * 100,
                 person_id: user_id, description: description, created_at: date
  end
end
