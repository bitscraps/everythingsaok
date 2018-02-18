module ApplicationHelper
  def get_name_from(email)
    email.gsub!(/\@.*/, '').gsub(/[\-|\_|\.]/, ' ')
    email.capitalize
  end
end
