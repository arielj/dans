# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  def new
    @tran = MoneyTransaction.new
  end

  def create
    @tran = MoneyTransaction.create create_transaction_params.merge(category: 'general')
    if @tran.save
      flash[:success] = t('added.money_transaction')
      redirect_to root_path
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

  private

  def create_transaction_params
    params.require(:money_transaction).permit(:amount, :description, :done)
  end
end
