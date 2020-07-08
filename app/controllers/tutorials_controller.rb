class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom == true && current_user.nil?
      four_oh_four
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
