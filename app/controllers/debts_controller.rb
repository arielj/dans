class DebtsController < ApplicationController
  before_action :load_debt

  def add_payment
  end

  def do_add_payment
    @payment = @debt.create_payment add_payment_attributes
  end

private
  def load_debt
    @debt = Debt.find(params[:id])
  end

  def add_payment_attributes
    params.require(:payment).permit(:amount, :description)
  end
end
