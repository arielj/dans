class DashboardController < ApplicationController
  def index
    @persons_transactions = MoneyTransaction.where('category != "general" AND created_at >= ?', Date.today.beginning_of_day)
    @general_transactions = MoneyTransaction.where(category: 'general').where('created_at >= ?', Date.today.beginning_of_day)
    @totals = {
      persons_in: @persons_transactions.total_in,
      persons_out: @persons_transactions.total_out,
      general_in: @general_transactions.total_in,
      general_out: @general_transactions.total_out,
    }
    @totals[:in] = @totals[:persons_in]+@totals[:general_in]
    @totals[:out] = @totals[:persons_out]+@totals[:general_out]
    @totals[:total] = @totals[:in]-@totals[:out]

    @birthday = Person.birthday_today
  end
end
