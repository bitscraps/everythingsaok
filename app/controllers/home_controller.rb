class HomeController < ApplicationController
  def index
    redirect_to documentation_path and return if current_user
  end
end
