# typed: true
# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  include MoneyTransactionsHelper

  def new
    @tran = MoneyTransaction.new
  end

  def create
    @tran = MoneyTransaction.create create_transaction_params.merge(category: 'general')
    if @tran.save
      redirect_to root_path, success: t('added.money_transaction')
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
end
