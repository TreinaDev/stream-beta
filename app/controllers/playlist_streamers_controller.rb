class PlaylistStreamersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_playlist, only: %i[new create]


  def new
    @playlist_streamer = PlaylistStreamer.new
    @streamers = Streamer.order(:name)
  end

  def create
    @playlist_streamer = @playlist.playlist_streamers.new(playlist_streamer_params)

    @playlist_streamer.save

    redirect_to @playlist, success: t('.success')
  end

  # def edit
  #   @subscription_plan_streamer = SubscriptionPlanStreamer.find(params[:id])
  #   @subscription_plan = @subscription_plan_streamer.subscription_plan
  #   @streamers = Streamer.order(:name)
  # end

  # def update
  #   @subscription_plan_streamer = SubscriptionPlanStreamer.find(params[:id])
  #   @subscription_plan_streamer.update(subscription_plan_streamer_params)

  #   redirect_to @subscription_plan_streamer.subscription_plan, success: t('.success')
  # end

  private

  def playlist_streamer_params
    params.require(:playlist_streamer).permit(:streamer_id)
  end

  def set_playlist
    @playlist = Playlist.find(params[:playlist_id])
  end
end
