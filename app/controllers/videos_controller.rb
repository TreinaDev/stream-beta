class VideosController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update inactive_videos]
  before_action :user_must_fill_profile
  before_action :set_video, only: %i[edit update show]

  def index
    @videos = Video.active.streamer_active
  end

  def new
    @video = Video.new
    @categories = VideoCategory.all.order(:title)
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
    @user_video = current_user&.user_videos&.find_by(video: @video)

    return if current_user&.admin?

    redirect_to root_path, alert: 'Vídeo Inativo!' if @video.inactive?

    redirect_to root_path, alert: 'Streamer Inativo!' if @video.streamer.inactive?
    @video_watched = VideoHistory.find_by(video: @video, user: current_user)
  end

  def edit
    @categories = VideoCategory.all.order(:title)
  end

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

  def search
    videos = Video.where('title like ?', "%#{params[:query]}%")
    with_streamers = Video.joins(:streamer).where('name like ?', "%#{params[:query]}%")
    with_category = Video.joins(:video_categories)
                         .where('video_categories.title like ?', "%#{params[:query]}%")
    @videos = Utils.concat_search([videos, with_streamers, with_category])
    render :index
  end

  private

  def video_params
    params.require(:video).permit(:title, :duration, :video_url, :maturity_rating, :streamer_id, :allow_purchase,
                                  :status, :value, video_category_ids: [])
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
