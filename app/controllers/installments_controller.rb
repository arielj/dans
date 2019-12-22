# frozen_string_literal: true

class InstallmentsController < ApplicationController
  before_action :load_installment

  def new_payment; end

  def add_payment
    ignore_recharge = params[:ignore_recharge] == '1'
    ignore_month_recharge = params[:ignore_month_recharge] == '1'
    @payment = @installment.create_payment add_payment_attributes, ignore_recharge, ignore_month_recharge
  end

  private

  def load_installment
    @installment = Installment.find(params[:id])
  end

  def add_payment_attributes
    params.require(:payment).permit(:amount, :description, :created_at)
  end
end
