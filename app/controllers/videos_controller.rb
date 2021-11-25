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

    @video.request_token if @video.allow_purchase?

    if @video.save
      redirect_to @video, success: t('.success')
    else
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
    @user_video = current_user&.user_videos&.find_by(video: @video)
  end

  private

  def video_params
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating, :streamer_id, :allow_purchase,
                                  :value)
  end
end
