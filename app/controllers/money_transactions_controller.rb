# typed: true
# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  include MoneyTransactionsHelper

  def new
    @tran = MoneyTransaction.new done: false
  end

  def create
    @tran =
      if params[:money_transaction][:payable_type] == 'Installment'
        installment = Installment.find(params[:money_transaction][:payable_id])
        ignore_recharge = params[:ignore_recharge] == '1'
        ignore_month_recharge = params[:ignore_month_recharge] == '1'
        installment.create_payment installment_payment_attributes, ignore_recharge, ignore_month_recharge
      elsif params[:money_transaction][:payable_type] == 'Debt'
        debt = Debt.find(params[:money_transaction][:payable_id])
        debt.create_payment debt_payment_attributes
      else
        MoneyTransaction.create create_transaction_params.merge(category: 'general')
      end

    if params[:button] == 'save_and_receipt'
      num = MoneyTransaction.last_receipt + 1
      @tran.update_attribute :receipt, num
    end

    if @tran.save
      flash[:success] = 'Guardado'

      redirect =
        if @tran.person
          options =
            case @tran.payable
            when Installment then { tab: :memberships, membership_id: @tran.payable.membership_id }
            when Debt then { tab: :debts }
            else {}
            end

          options[:show_receipt] = @tran.receipt if params[:button] == 'save_and_receipt'

          edit_person_path(@tran.person, options)
        else
          root_path
        end

      redirect_to redirect
    else
      render action: :new
    end
  end

  def edit
    @tran = MoneyTransaction.find(params[:id])
  end

  def update
    @tran = MoneyTransaction.find(params[:id])
    @tran.attributes = update_transaction_params
    if params[:button] == 'save_and_receipt'
      @tran.receipt ||= MoneyTransaction.last_receipt + 1
    end
    @tran.save
  end

  def destroy
    MoneyTransaction.find(params[:id]).destroy
    flash[:success] = t('destroyed.money_transaction')
    redirect_back fallback_location: root_path
  end

  def close_daily_cash
    MoneyTransaction.today.update_all daily_cash_closer: false
    T.must(MoneyTransaction.today.last).update_column :daily_cash_closer, true
    flash.now[:success] = 'Cierre marcado'
  end

  def receipt
    @receipt_items = MoneyTransaction.where(receipt: params[:number])
    send_data generate_pdf(@receipt_items), filename: "receipt_#{T.must(@receipt_items.first).receipt}.pdf", type: "application/pdf", disposition: :inline
  end

  def receipt_multiple
    @receipt_items = MoneyTransaction.where(id: params[:print])
    nums = @receipt_items.pluck(:receipt).uniq

    if nums.count != 1
      @receipt_items.update_all receipt: MoneyTransaction.last_receipt + 1
    end
  end

  private

  def create_transaction_params
    params
      .require_typed(:money_transaction, TA[ActionController::Parameters].new)
      .permit(:amount, :description, :done)
  end

  def update_transaction_params
    params
      .require_typed(:money_transaction, TA[ActionController::Parameters].new)
      .permit(:amount, :description)
  end

  def installment_payment_attributes
    params
      .require_typed(:money_transaction, TA[ActionController::Parameters].new)
      .permit(:amount, :description, :done, :paid_at)
  end

  def debt_payment_attributes
    params
      .require_typed(:money_transaction, TA[ActionController::Parameters].new)
      .permit(:amount, :description, :paid_at)
  end
end
