class Documentation::BadgesController < ApplicationController
  def show
    @document = Document.find(params[:documentation_id])
    generate_image

    send_file('/tmp/badge.jpg',
              filename: 'badge',
              type: 'image/png',
              disposition: 'inline')
  end

  private

  def generate_image
    base_image = MiniMagick::Image.open("#{Rails.root}/app/assets/images/badge_base.png")
    base_image.combine_options do |c|
      if @document.last_review
        c.draw "text 162,30 \"#{@document.last_review.strftime('%d %B %Y')}\""
        c.draw "text 172,51 \"#{@document.reviews.last.review_by.email}\""
      else
        c.draw 'text 162,30 "Not Yet Reviewed"'
      end
      # c.font '-*-helvetica-*-r-*-*-18-*-*-*-*-*-*-2'
      # c.fill("#FFFFFF")
    end

    base_image.write('/tmp/badge.jpg')
  end
end
