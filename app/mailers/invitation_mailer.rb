class InvitationMailer < ApplicationMailer
  def invitation_email
    @invitee_email = params[:invitee_email]
    @invitee_handle = params[:invitee_handle]
    @user = params[:user]
    @url = 'https://brownfield-of-dreams-sb-rp.herokuapp.com/register'
    mail(to: @invitee_email, subject: 'An invite to Brownfield of Dreams')
  end
end
