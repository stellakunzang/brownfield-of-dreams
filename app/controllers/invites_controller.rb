class InvitesController < ApplicationController 

  def new
  end

  def create 
    if handle_in_system?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else 
      @invitee_handle = params[:github_handle]
      @user = current_user
    end
    redirect_to dashboard_path

  end
  
  private 

  def handle_in_system?
    github_user = GithubUsers.new(current_user.github_token)
    handles = github_user.followers.map(&:handle)
    binding.pry
  end
end