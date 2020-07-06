class WelcomeController < ApplicationController
  def index
    @tutorials = Tutorial.filtered_tutorials(params, current_user)

  end
end
