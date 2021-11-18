class StreamersController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update]
  before_action :user_must_fill_profile

  def index
    @streamers = Streamer.all
  end

  def show
    @streamer = Streamer.find(params[:id])
  end

  def new
    @streamer = Streamer.new
  end

  def create
    @streamer = Streamer.new(streamer_params)

    if @streamer.save
      redirect_to streamer_path(@streamer), success: t('.success')
    else
      render :new
    end
  end

  def edit
    @streamer = Streamer.find(params[:id])
  end

  def update
    @streamer = Streamer.find(params[:id])

    if @streamer.update streamer_params
      redirect_to streamer_path(@streamer), success: t('.success')
    else
      render :edit
    end
  end

  def inactive
    streamer = Streamer.find(params[:id])
    streamer.inactive!
    redirect_to streamers_path
  end

  private

  def streamer_params
    params.require(:streamer).permit(:name, :avatar, :facebook_url,
                                     :youtube_url, :instagram_handle, :twitter_handle)
  end
end
