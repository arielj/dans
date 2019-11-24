# frozen_string_literal: true

module MoneyTransactionsHelper
  def transactions_totals(people, general)
    totals = {
      persons_in: people.total_in,
      persons_out: people.total_out,
      general_in: general.total_in,
      general_out: general.total_out
    }

    totals[:in] = totals[:persons_in] + totals[:general_in]
    totals[:out] = totals[:persons_out] + totals[:general_out]
    totals[:total] = totals[:in] - totals[:out]
    totals
  end
end
