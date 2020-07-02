class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)
    if tutorial.save 
      # link = "<a href=#{tutorial_videos_path(tutorial)}> View it here.</a>"
      # flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here.', tutorial_videos_path(tutorial))}.".html_safe
      # flash[:success] = %Q[Sucessfully created tutorial. <a href=#{tutorial_videos_path(tutorial)}> View it here.</a>]
      # flash[:success] = "Successfully created tutorial. #{view_context.link_to 'View it here.', tutorial_videos_path(tutorial)}".html_safe
      # flash[:success] = "Successfully created tutorial. #{link_to 'View it here', :controller => 'videos', :action => 'index'}"
      flash[:success] = "Successfully created tutorial. View it here."
      redirect_to admin_dashboard_path
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
    # params.require(:tutorial).permit(:tag_list)
    params.require(:tutorial).permit(:title, :description, :thumbnail, :playlist_id)
  end
end
