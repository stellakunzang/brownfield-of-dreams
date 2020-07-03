class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:github_user_token] = nil
    redirect_to root_path
  end

  def update 
    token = {token: request.env['omniauth.auth']['credentials']['token']}
    current_user.update(token)
    session[:github_user_token] = token[:token]
    redirect_to dashboard_path
  end
end
