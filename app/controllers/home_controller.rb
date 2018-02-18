class HomeController < ApplicationController
  def index
    redirect_to documentation_index_path and return if current_user
  end
end
