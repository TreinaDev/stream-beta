class VideosController < ApplicationController
  before_action :require_admin_login, only: %i[new create]

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to video_path(@video), success: t('.success')
    else
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating)
  end
end
