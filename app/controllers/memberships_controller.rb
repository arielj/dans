# frozen_string_literal: true

class MembershipsController < ApplicationController
  def create
    @membership = Membership.new create_membership_params
    if @membership.save
      redirect_back fallback_location: edit_person_path(@membership.person, tab: 'memberships')
    else
      render template: 'people/new_membership'
    end
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def add_installments
    @membership = Membership.find(params[:id])
  end

  def do_add_installments
    @membership = Membership.find(params[:id])
    year = @membership.installments.first&.year || DateTime.current.year
    @membership.create_installments(params[:month_from], params[:month_to], year, nil, params[:amount])
    redirect_back fallback_location: edit_person_path(@membership.person, tab: :memberships, membership_id: @membership.id)
  end

  def edit
    @membership = Membership.find(params[:id])
    @membership.update_unpaid_installments = true
    @membership.update_paid_installments = false

    from = @membership.installments.order(month: :asc).first&.month
    from ||= Setting.fetch(:preselected_installments_month_from, :january)
    @membership.create_installments_from = from

    to = @membership.installments.order(month: :asc).last&.month
    to ||= Setting.fetch(:preselected_installments_month_to, :december)
    @membership.create_installments_to = to
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.attributes = update_membership_params
    @membership.save

    flash[:success] = 'Paquete editado'
    redirect_to edit_person_path(@membership.person, tab: :memberships, membership_id: @membership.id)
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    flash[:success] = 'Paquete borrado'
    redirect_to edit_person_path(@membership.person, tab: :memberships)
  end

  private

  def create_membership_params
    params
      .require(:membership)
      .permit(:person_id, :amount, :amount_with_discount, :use_custom_amount,
              :create_installments_from, :create_installments_to,
              :use_non_regular_fee, :use_fees_with_discount, :use_manual_discount,
              :manual_discount, :apply_discounts, schedule_ids: [])
  end

  def update_membership_params
    params
      .require(:membership)
      .permit(:amount, :amount_with_discount, :use_custom_amount, :create_installments_from,
              :update_unpaid_installments, :update_paid_installments,
              :create_installments_to, :use_non_regular_fee,
              :use_manual_discount, :manual_discount,
              :use_fees_with_discount, :apply_discounts, schedule_ids: [])
  end
end
