class InvitationMailer < ApplicationMailer
  def invitation_email
    @user = params[:user]
    @url = "https://brownfield-of-dreams-sb-rp.herokuapp.com/users/#{@user.id}/activate"
    mail(to: @user.email, subject: 'An invite to Brownfield of Dreams')
  end

end
