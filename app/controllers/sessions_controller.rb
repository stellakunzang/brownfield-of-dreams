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
    session[:github_token] = nil
    redirect_to root_path
  end

  def update
    github_token = request.env['omniauth.auth'][:credentials][:token]
    user_handle(github_token)
    current_user.update(github_token: github_token, handle: handle)
    session[:github_token] = github_token if current_user.save
    redirect_to dashboard_path
  end

  def failure
    flash[:error] = 'Connecting to Github was Unsuccessful'
    redirect_to dashboard_path
  end

  def user_handle(token)
    binding.pry
    GithubService.new(token).get_url[:login]
  end
end
