class OrganisationMailer < ApplicationMailer
  def send_invite(invite)
    @invite = invite
    mail(to: @invite.email, subject: 'Invite to make sure everythings A.OK')
  end
end
