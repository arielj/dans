class ReportsController < ApplicationController
  include MoneyTransactionsHelper

  def daily_cash
    @date = params[:date] || Date.today
    @date = Date.parse(@date) unless @date.is_a?(Date)
    range = @date.beginning_of_day..@date.end_of_day

    scp = MoneyTransaction.where(created_at: range)
    scp = scp.where('description LIKE ?', "%#{params[:text]}%") if params[:text].present?

    @people_transactions = scp.where.not(category: 'general')
    @general_transactions = scp.where(category: 'general')
    @totals = transactions_totals(@people_transactions, @general_transactions)
  end

  def payments
    @date_from = params[:date_from] || Date.today
    @date_from = Date.parse(@date_from) unless @date_from.is_a?(Date)

    @date_to = params[:date_to] || Date.today
    @date_to = Date.parse(@date_to) unless @date_to.is_a?(Date)
    range = @date_from.beginning_of_day..@date_to.end_of_day

    @payments = MoneyTransaction.where(created_at: range).joins(:person)
    case params[:direction]
    when 'done'; @payments = @payments.done
    when 'received'; @payments = @payments.received
    end
  end
end
