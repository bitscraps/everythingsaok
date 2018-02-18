class Documentation::ApproveController < ApplicationController
  def create
    document = Document.find(params[:documentation_id])
    document.reviews << Review.create(review_by: current_user, approved: true)
    document.update!(last_review: Time.now, assigned_to: nil)

    redirect_to documentation_index_path
  end
end
