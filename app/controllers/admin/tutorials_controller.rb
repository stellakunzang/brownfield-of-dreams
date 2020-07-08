class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if missing_params.present?
      flash[:error] = "Please enter a #{missing_params}."
      redirect_to new_admin_tutorial_path
    elsif valid_thumbnail?(params[:tutorial][:thumbnail])
      tutorial = Tutorial.create(new_tutorial_params)
      flash[:success] = 'Successfully created tutorial.'
      redirect_to "/tutorials/#{tutorial.id}"
    else
      flash[:error] = 'Please enter a valid thumbnail.'
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
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
    thumbnail = thumbnail.downcase
    valid_thumbnail1 = 'http://img.youtube.com'
    valid_thumbnail2 = 'https://img.youtube.com'
    valid_thumbnail3 = 'img.youtube.com'
    scenario1 = thumbnail[0..21] == valid_thumbnail1[0..21]
    scenario2 = thumbnail[0..22] == valid_thumbnail2[0..22]
    scenario3 = thumbnail[0..14] == valid_thumbnail3[0..14]

    scenario1 || scenario2 || scenario3
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

  def missing_params
    missing_params = []
    params[:tutorial].each do |key, value|
      missing_params << key if value == ''
    end
    missing_params.join(', ')
  end
end
