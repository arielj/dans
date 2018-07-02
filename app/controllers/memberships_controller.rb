class MembershipsController < ApplicationController
  def create
    @membership = Membership.new create_membership_params
    if @membership.save
      redirect_to edit_person_path @membership.person
    else
      render template: 'people/new_membership'
    end
  end

  def show
    @membership = Membership.find(params[:id])
  end

private
  def create_membership_params
    params.require(:membership).permit(:person_id, :amount, schedule_ids: [])
  end
end
