class Settings::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @invites = Invite.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to settings_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
