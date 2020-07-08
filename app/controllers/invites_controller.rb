class InvitesController < ApplicationController
  def new; end

  def create
    invite = Invite.new(current_user.github_token)
    if invite.github_handle_missing?(params[:github_handle])
      flash[:error] = "Please enter a valid github handle."
    elsif invite.github_email_missing?(params[:github_handle])
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else
      invite.send_invite(params[:github_handle], current_user)
      flash[:success] = 'Successfully sent invite!'
    end
    redirect_to dashboard_path
  end

end
