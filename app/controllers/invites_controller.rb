class InvitesController < ApplicationController
  before_action :authenticate_user!

  def create
    @invite = Invite.create(invite_params)
    OrganisationMailer.send_invite(@invite).deliver
    redirect_to settings_users_path 
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end
