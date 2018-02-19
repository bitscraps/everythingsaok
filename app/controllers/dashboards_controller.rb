class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @reviews = Document.where(assigned_to: current_user)
                       .where('last_review >= ? OR last_review IS null', 3.months.ago)
                       .order(last_review: :desc)
  end
end