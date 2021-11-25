class VideosController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update inactive_videos]
  before_action :user_must_fill_profile
  before_action :set_video, only: %i[edit update show]

  def index
    @videos = Video.active.streamer_active
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

  def show
    redirect_to root_path, alert: 'Vídeo Inativo!' if @video.inactive? && !current_user.admin?

    redirect_to root_path, alert: 'Streamer Inativo!' if @video.streamer.inactive? && !current_user.admin?
  end

  def edit; end

  def update
    if @video.update video_params
      redirect_to @video, success: t('.success')
    else
      render :edit
    end
  end

  def inactive_videos
    @videos = Video.all.select(&:inactive?)
  end

  private

  def video_params
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating, :streamer_id, :status)
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
