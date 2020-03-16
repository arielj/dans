# typed: true
# frozen_string_literal: true

class InstallmentsController < ApplicationController
  before_action :load_installment

  def destroy
    ins = Installment.find(params[:id])
    person = ins.person
    ins.destroy

    flash[:success] = t('destroyed.installment')
    redirect_back fallback_location: edit_person_path(person, tab: :memberships)
  end

  def edit
    @installment = Installment.find(params[:id])
  end

  def update
    @installment = Installment.find(params[:id])
    @installment.update_amount!(params[:installment][:amount])
  end

  private

  def load_installment
    @installment = Installment.find(params[:id])
  end
end
