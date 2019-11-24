# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  def new
    @tran = MoneyTransaction.new
  end

  def create
    @tran = MoneyTransaction.create create_transaction_params.merge(category: 'general')
    if @tran.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def destroy
    MoneyTransaction.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def create_transaction_params
    params.require(:money_transaction).permit(:amount, :description, :done)
  end
end
