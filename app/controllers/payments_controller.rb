# frozen_string_literal: true

# handles money transactions that pays installments
class PaymentsController < ApplicationController
  before_action :load_installment

  def new
    @payment = MoneyTransaction.new description: 'cuota', amount: @installment.to_pay
  end

  def create
    ignore_recharge = params[:ignore_recharge] == '1'
    ignore_month_recharge = params[:ignore_month_recharge] == '1'
    @payment = @installment.create_payment add_payment_attributes, ignore_recharge, ignore_month_recharge

    if params[:button] == 'save_and_receipt'
      num = (MoneyTransaction.order(receipt: :desc).first&.receipt || 0) + 1
      @payment.update_attribute :receipt, num
    end
  end

  def edit
    @payment = @installment.payments.find(params[:id])
  end

  def update
    @payment = @installment.payments.find(params[:id])
    @payment.attributes = add_payment_attributes
    @payment.save
  end

  private

  def load_installment
    @installment = Installment.find(params[:installment_id])
  end

  def add_payment_attributes
    params.require_typed(:payment, TA[ActionController::Parameters].new).permit(:amount, :description, :paid_at)
  end
end