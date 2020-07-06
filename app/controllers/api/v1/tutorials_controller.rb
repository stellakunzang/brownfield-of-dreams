class Api::V1::TutorialsController < ApplicationController
  def index
    binding.pry
    render json: Tutorial.all
  end

  def show
    render json: Tutorial.find(params[:id])
  end
end
