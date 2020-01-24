# typed: true
# frozen_string_literal: true

class ReportsController < ApplicationController
  include MoneyTransactionsHelper

  def daily_cash
    @date = params[:date] || Date.today
    @date = Date.parse(@date) unless @date.is_a?(Date)

    scp = MoneyTransaction.for_day(@date)
    scp = scp.where('description LIKE ?', "%#{params[:text]}%") if params[:text].present?

    @people_transactions = scp.where('category IS NULL OR category != "general"').where.not(person_id: nil)
    @general_transactions = scp.where('category = "general" OR person_id IS NULL')
    @totals = transactions_totals(@people_transactions, @general_transactions)
  end

  def payments
    @date_from = params[:date_from] || Date.today
    @date_from = Date.parse(@date_from) unless @date_from.is_a?(Date)

    @date_to = params[:date_to] || Date.today
    @date_to = Date.parse(@date_to) unless @date_to.is_a?(Date)
    range = @date_from.beginning_of_day..@date_to.end_of_day

    @payments = MoneyTransaction.where(created_at: range).joins(:person)

    @payments = case params[:direction]
                when 'done' then @payments.done
                else
                  params[:direction] = 'received'
                  @payments.received
                end
  end

  def receipts
    @receipt_items = MoneyTransaction.where(receipt: params[:receipt]) if params[:receipt]
  end

  def students_hours
    @year = (params[:year] || Date.today.year).to_i
    @klasses = Klass.all
    @students = Person.active.students.order(name: :asc)
    @data = {}
    mids = Installment.where(year: @year).pluck('distinct(membership_id)')
    Membership.where(person_id: @students.pluck(:id), id: mids).includes(:schedules).each do |m|
      @data[m.person_id] ||= {}
      m.schedules.each do |sch|
        @data[m.person_id][sch.klass_id] ||= 0
        @data[m.person_id][sch.klass_id] += sch.duration
      end
    end
    @stats = {}
    @data.each do |_std, klasses|
      sum = klasses.values.sum
      @stats[sum] ||= 0
      @stats[sum] += 1
    end

    if params[:button] == 'export'
      send_file(StudentsHoursReportExporter.to_xls(@year, @klasses, @students, @data, @stats)) and return
    end
  end

  def debts
    @debts = Debt.waiting.includes(:person)
    @debts = @debts.search(params[:term]) if params[:term]
    @total = @debts.map(&:amount).sum
  end

  def installments
    ins = Installment.includes(:person)

    if params[:klass_id].present?
      membership_ids = Klass.find(params[:klass_id]).membership_ids
      ins = ins.where(membership_id: membership_ids)
    end

    ins = ins.waiting unless params[:include_paid].present?
    ins = ins.where(year: params[:year]) if params[:year].present?
    ins = ins.where(month: params[:month]) if params[:month].present?
    ins = ins.for_active_users unless params[:include_inactive_users].present?
    ins = ins.with_recharge if params[:only_with_recharge].present?
    @installments = ins
  end
end
