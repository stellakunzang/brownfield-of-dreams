class RegistrationMailer < ApplicationMailer

  def confirmation_email
    @user = params[:user]
    @url = 'https://brownfield-of-dreams-sb-rp.herokuapp.com/dashboard'
    mail(to: @user.email, subject: "Please activate your new account")
  end

end
