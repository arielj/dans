# typed: true
# frozen_string_literal: true

class OldInstallment < OldRecord
  self.table_name = :installments

  def to_new
    puts "Installment #{id}"

    a = amount != 0 ? T.must(amount) * 100 : 0

    if Membership.exists?(id: membership_id)
      Installment.create! id: id, year: year, month: month, amount_cents: a,
                          membership_id: membership_id, status: T.must(status).to_sym
    else
      puts 'no membership'
    end
  end
end
