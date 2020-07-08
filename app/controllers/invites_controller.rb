class InvitesController < ApplicationController 

  def new
  end

  def create 
    if !handle_in_system?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else 
      @invitee_handle = params[:github_handle]
      @user = current_user
      InvitationMailer.with(user: @user, invitee_handle: @invitee_handle).invitation_email.deliver_now
      flash[:success] = 'Successfully sent invite!'
    end
    redirect_to dashboard_path

  end
  
  private 

  def handle_in_system?
    handles_in_system.include?(params[:github_handle])
  end

  def handles_in_system
    github_user = GithubUsers.new(current_user.github_token)
    handles = github_user.followers.map(&:handle)
    handles << github_user.followings.map(&:handle)
    handles = handles.flatten.uniq
  end
end