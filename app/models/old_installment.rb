# frozen_string_literal: true

class OldInstallment < OldRecord
  self.table_name = :installments

  def to_new
    a = amount != 0 ? amount * 100 : 0

    i = Installment.new id: id, year: year, month: month, amount_cents: a,
                        membership_id: membership_id, status: status.to_sym

    puts i.errors.full_messages if i.invalid?

    i.save
  end
end
