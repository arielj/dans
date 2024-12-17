# frozen_string_literal: true

class ReportsController < ApplicationController
  include MoneyTransactionsHelper

  before_action :allow_only_admin, except: :daily_cash

  def daily_cash
    @date = params[:date] || DateTime.current.to_date
    @date = Date.parse(@date) unless @date.is_a?(Date)

    @data = 7.days.ago if current_admin.operator? && @date < 7.days.ago

    scp = MoneyTransaction.for_day(@date)
    scp = scp.where('description LIKE ?', "%#{params[:text]}%") if params[:text].present?

    @people_transactions = scp.where('category IS NULL OR category != "general"').where.not(person_id: nil)
    @general_transactions = scp.where('category = "general" OR person_id IS NULL')
    @totals = transactions_totals(@people_transactions, @general_transactions)

    if params[:button] == 'export'
      send_file(DailyCashReportExporter.to_xls(@date, @people_transactions, @general_transactions, @totals)) and return
    end
  end

  def payments
    @date_from = params[:date_from] || DateTime.current.to_date
    @date_from = Date.parse(@date_from) unless @date_from.is_a?(Date)

    @date_to = params[:date_to] || DateTime.current.to_date
    @date_to = Date.parse(@date_to) unless @date_to.is_a?(Date)
    range = @date_from.beginning_of_day..@date_to.end_of_day

    @payments = MoneyTransaction.where(created_at: range).joins(:person)

    @payments = case params[:direction]
                when 'done' then @payments.done
                else
                  params[:direction] = 'received'
                  @payments.received
                end

    @payments = @payments.search(params[:search]) if params[:search].present?

    if params[:button] == 'export'
      send_file(PaymentsReportExporter.to_xls(@date_from, @date_to, @payments)) and return
    end
  end

  def receipts
    @receipt_items = MoneyTransaction.where(receipt: params[:receipt]) if params[:receipt]
  end

  def students_with_without_package
    @year = (params[:year] || DateTime.current.year).to_i
    @month = params[:month] || Date::MONTHNAMES[Date.today.month].downcase

    @data = Hash.new()
    @stats = {with: 0, without: 0, total: 0}

    # sum number of users per klass and with/without package
    Person.includes(installments: :klasses).where(installments: {year: @year, month: @month}).each do |per|
      inst = per.installments[0]
      next if per.inactive? && inst.amount_paid == Money.new(0)

      with_or_without = inst.klasses.length > 2 ? :with : :without
      inst.klasses.each do |kls|
        @data[kls.id] ||= {with: 0, without: 0, total: 0}
        @data[kls.id][with_or_without] += 1
        @data[kls.id][:total] += 1
      end
      @stats[with_or_without] += 1
      @stats[:total] += 1
    end

    @klasses = Klass.where(id: @data.keys)

    if params[:button] == 'export'
      send_file(StudentsHoursReportExporter.to_xls(@year, @klasses, @students, @data, @stats)) and return
    end
  end

  def extra_klasses_students
    @year = (params[:year] || DateTime.current.year).to_i
    @month = params[:month] || Installment.months_for_select[DateTime.current.month - 1].last
    @klasses = Klass.where.not(fixed_fee_cents: 0)
    @data = {}
    @totals = {}
    @klasses.each do |klass|
      @data[klass.id] = { regular: 0, non_regular: 0 }
      @totals[klass.id] = { regular: Money.new(0), non_regular: Money.new(0) }
      ms = klass.memberships_for_year_and_month(@year, @month)
      ms.each do |m|
        if m.use_non_regular_fee
          @data[klass.id][:non_regular] += 1
          @totals[klass.id][:non_regular] += (klass.non_regular_fee || Money.new(0))
        else
          @data[klass.id][:regular] += 1
          @totals[klass.id][:regular] += klass.fixed_fee
        end
      end
    end

    if params[:button] == 'export'
      send_file(ExtraKlassesStudentsReportExporter.to_xls(@year, @klasses, @data, @totals)) and return
    end
  end

  def debts
    @debts = Debt.waiting.includes(:person)
    @debts = @debts.search(params[:term]) if params[:term]
    @total = @debts.map(&:amount).sum
  end

  def installments
    params[:year] = Date.today.year unless params.key?(:year)
    params[:month] = Installment.months.keys[Date.today.month - 1] unless params.key?(:month)

    if params[:form_action] == 'export'
      send_file(InstallmentsReportExporter.to_xls(year: params[:year], month: params[:month], klass_id: params[:klass_id], state: params[:installment_state], include_inactive_users: params[:include_inactive_users], only_with_recharge: params[:only_with_recharge])) and return
    end

    ins = Installment.includes(:person)

    if params[:klass_id].present?
      membership_ids = Klass.find(params[:klass_id]).membership_ids
      ins = ins.where(membership_id: membership_ids)
    end

    ins =
      case params[:installment_state]
      when 'paid' then ins.not_waiting
      when 'waiting' then ins.waiting
      else ins
      end

    ins = ins.where(year: params[:year]) if params[:year].present?
    ins = ins.where(month: params[:month]) if params[:month].present?
    ins = ins.for_active_users unless params[:include_inactive_users].present?
    ins = ins.with_recharge if params[:only_with_recharge].present?
    @installments = ins
  end
end
