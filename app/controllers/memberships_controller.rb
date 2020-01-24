# typed: true
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
    @membership.create_installments(params[:month_from], params[:month_to], params[:year], params[:amount])
    redirect_back fallback_location: edit_person_path(@membership.person, tab: :memberships, membership_id: @membership.id)
  end

  private

  def create_membership_params
    params
      .require_typed(:membership, TA[ActionController::Parameters].new)
      .permit(:person_id, :amount, :use_custom_amount, :create_installments_from,
              :create_installments_to, schedule_ids: [])
  end
end
