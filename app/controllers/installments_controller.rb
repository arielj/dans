class InstallmentsController < ApplicationController
  before_action :load_installment

  def new_payment
  end

  def add_payment
    @payment = @installment.create_payment add_payment_attributes, params[:ignore_recharge] == '1', params[:ignore_month_recharge] == '1'
  end

private
  def load_installment
    @installment = Installment.find(params[:id])
  end

  def add_payment_attributes
    params.require(:payment).permit(:amount, :description)
  end
end
