class ReportsController < ApplicationController
  def daily_cash
    @date = params[:date] || Date.today
    @date = Date.parse(@date) unless @date.is_a?(Date)
    range = @date.beginning_of_day..@date.end_of_day

    scp = MoneyTransaction.where(created_at: range)
    scp = scp.where('description LIKE ?', "%#{params[:text]}%") if params[:text].present?

    @persons_transactions = scp.where.not(category: "general")
    @general_transactions = scp.where(category: 'general')
    @totals = {
      persons_in: @persons_transactions.total_in,
      persons_out: @persons_transactions.total_out,
      general_in: @general_transactions.total_in,
      general_out: @general_transactions.total_out,
    }
    @totals[:in] = @totals[:persons_in]+@totals[:general_in]
    @totals[:out] = @totals[:persons_out]+@totals[:general_out]
    @totals[:total] = @totals[:in]-@totals[:out]
  end
end
