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
        c.draw 'text 60,15 "Last Reviewed "'
        c.draw 'text 60,27 "on the 18th October 2017"'
        c.draw 'text 60,39 "By Dan Morris"'
      else
        c.draw 'text 60,15 "Not Yet Reviewed"'
      end
      # c.font '-*-helvetica-*-r-*-*-18-*-*-*-*-*-*-2'
      # c.fill("#FFFFFF")
    end

    base_image.write('/tmp/badge.jpg')
  end
end
