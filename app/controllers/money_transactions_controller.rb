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

  def destroy
    MoneyTransaction.find(params[:id]).destroy
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
    send_data generate_pdf(@receipt_items), filename: "receipt_#{@receipt_items.first.receipt}.pdf", type: "application/pdf", disposition: :attachment
  end

  private

  def create_transaction_params
    params.require(:money_transaction).permit(:amount, :description, :done)
  end
end
