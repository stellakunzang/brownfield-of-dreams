class UsersController < ApplicationController
  def show
    @github_user = if current_user.github_token.nil?
                     current_user
                   else
                     GithubUsers.new(current_user.github_token)
                   end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      RegistrationMailer.with(user: @user).confirmation_email.deliver_now
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.first_name} #{@user.last_name}. This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    session[:user_id] = @user.id
    @user.update(active: true)
    if @user.save
      flash[:notice] = 'Thank you! Your account is now activated.'
      current_user.reload
      redirect_to dashboard_path
    end
  end

  def activate
    update
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
