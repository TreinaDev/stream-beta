class VideosController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update]
  before_action :user_must_fill_profile
  before_action :set_video, only: %i[show edit update]

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to @video, success: t('.success')
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @video.update video_params
      redirect_to @video, success: t('.success')
    else
      render :edit
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating, :streamer_id)
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
