class VideosController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :user_must_fill_profile

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
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating, :streamer_id)
  end
end
