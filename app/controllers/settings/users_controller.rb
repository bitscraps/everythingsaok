class Settings::UsersController < ApplicationController
  def index
    @users = User.all
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