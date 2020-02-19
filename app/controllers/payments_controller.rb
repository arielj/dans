# frozen_string_literal: true

# handles money transactions that pays installments
class PaymentsController < ApplicationController
  before_action :load_installment

  def new
    @payment = @installment.payments.new description: 'cuota', amount: @installment.to_pay
  end

  private

  def load_installment
    @installment = Installment.find(params[:installment_id])
  end
end
