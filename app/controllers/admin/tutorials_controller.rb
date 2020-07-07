class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    # if !empty_params.empty?
    #   flash[:error] = "Please Enter a valid #{empty_params}."
    #   redirect_to redirect_to new_admin_tutorials_path
    if valid_thumbnail?(params[:tutorial][:thumbnail])
      tutorial = Tutorial.create(new_tutorial_params)
      flash[:error] = "Successfully created tutorial."
      redirect_to tutorials_path(tutorial)
    else 
      flash[:error] = "Please enter a vaid thumbnail."
      redirect_to new_admin_tutorials_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def valid_thumbnail?(thumbnail)
    valid_thumb_1 = "http://img.youtube.com"
    valid_thumb_2 = "https://img.youtube.com"
    valid_thumb_3 = "img.youtube.com"
    binding.pry
   # thumbnail.include?(valid_thumbnail_1) || thumbnail.include?(valid_thumbnail_2 || thumbnail.include?(valid_thumbnail_3)
  end

  # def results
  #   YoutubePlaylistResults.new(params[:playlist_id])
  # end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
