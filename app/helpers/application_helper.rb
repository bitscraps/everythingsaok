module ApplicationHelper
  def get_name_from(email)
    email.gsub!(/\@.*/, '')
    email.humanize
  end
end
