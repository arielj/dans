class DashboardController < ApplicationController
  include MoneyTransactionsHelper

  def index
    scp = MoneyTransaction.where('created_at >= ?', Date.today.beginning_of_day)
    @people_transactions = scp.where.not(category: 'general')
    @general_transactions = scp.where(category: 'general')
    @totals = transactions_totals(@people_transactions, @general_transactions)

    @birthday = Person.birthday_today
  end
end
