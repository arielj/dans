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
        ignore = false
        ignore = :month if params[:ignore_month_recharge] == '1'
        ignore = :second if params[:ignore_second_recharge] == '1'
        ignore = :first if params[:ignore_recharge] == '1'

        # in case the person already paid something and we want to change the
        # installment to paid after that
        if installment.to_pay(ignore_recharge: ignore) == Money.new(0) && installment.waiting?
          installment.paid!
          installment.payments.last
        else
          installment.create_payment installment_payment_attributes, ignore_recharge: ignore
        end
      elsif params[:money_transaction][:payable_type] == 'Debt'
        debt = Debt.find(params[:money_transaction][:payable_id])
        debt.create_payment debt_payment_attributes
      elsif params[:money_transaction][:person_id]
        MoneyTransaction.create create_person_transaction_params
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
            else { tab: :person_payments }
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
    transaction = MoneyTransaction.find(params[:id])

    transaction.destroy # destroy money transaction
    transaction.payable&.waiting! # fix payable object status

    flash[:success] = t('destroyed.money_transaction')
    redirect_back fallback_location: root_path
  end

  def close_daily_cash
    MoneyTransaction.today.update_all daily_cash_closer: false
    MoneyTransaction.today.last.update_column :daily_cash_closer, true
    flash.now[:success] = 'Cierre marcado'
  end

  def receipt
    @receipt_items = MoneyTransaction.where(receipt: params[:number])
    send_data generate_pdf(@receipt_items), filename: "receipt_#{@receipt_items.first.receipt}.pdf", type: "application/pdf", disposition: :inline
  end

  def receipt_multiple
    @receipt_items = MoneyTransaction.where(id: params[:print])
    nums = @receipt_items.pluck(:receipt).select(&:present?).uniq

    if nums.count != 1
      @receipt_items.update_all receipt: MoneyTransaction.last_receipt + 1
    end
  end

  private

  def create_transaction_params
    params
      .require(:money_transaction)
      .permit(:amount, :description, :done)
  end

  def update_transaction_params
    params
      .require(:money_transaction)
      .permit(:amount, :description, :done)
  end

  def installment_payment_attributes
    params
      .require(:money_transaction)
      .permit(:amount, :description, :done, :paid_at)
  end

  def debt_payment_attributes
    params
      .require(:money_transaction)
      .permit(:amount, :description, :paid_at)
  end

  def create_person_transaction_params
    params
      .require(:money_transaction)
      .permit(:amount, :description, :person_id)
  end
end
