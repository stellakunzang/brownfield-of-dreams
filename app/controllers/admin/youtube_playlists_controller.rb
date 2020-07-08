class Admin::YoutubePlaylistsController < Admin::BaseController
  def new
    @admin = current_user
  end

  def create
    if results.snippet.nil?
      flash[:error] = 'Sorry, that ID is not valid. Try again?'
      redirect_to new_admin_youtube_playlist_path
    else
      tutorial_from_playlist = Tutorial.create(new_tutorial_params)
      tutorial_from_playlist.create_playlist_videos
      context = view_context.link_to('View it here', tutorial_path(tutorial_from_playlist.id))
      flash[:success] = "Successfully created tutorial. #{context}."
      redirect_to admin_dashboard_path
    end
  end

  private

  def results
    YoutubePlaylistResults.new(params[:playlist_id])
  end

  def new_tutorial_params
    results.parameters
  end
end
