class StreamersController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update inactive_streamers]
  before_action :user_must_fill_profile
  before_action :set_streamer, only: %i[show edit update]

  def index
    @streamers = Streamer.all.reject(&:inactive?)
  end

  def show; end

  def new
    @streamer = Streamer.new
  end

  def create
    @streamer = Streamer.new(streamer_params)

    if @streamer.save
      redirect_to @streamer, success: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @streamer.update streamer_params
      redirect_to @streamer, success: t('.success')
    else
      render :edit
    end
  end

  def inactive_streamers
    @streamers = Streamer.select(&:inactive?)
  end

  def search
    @streamers = Streamer.where('name like ?', "%#{params[:query]}%").reject(&:inactive?)
    render :index
  end

  private

  def streamer_params
    params.require(:streamer).permit(:name, :avatar, :facebook_url,
                                     :youtube_url, :instagram_handle, :twitter_handle, :status)
  end

  def set_streamer
    @streamer = Streamer.find(params[:id])
  end
end
