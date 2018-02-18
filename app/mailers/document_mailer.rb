class DocumentMailer < ApplicationMailer
  def new_document(user, document)
    @user = user
    @document = document
    mail(to: @user.email, subject: 'You have a new document to aok')
  end
end
