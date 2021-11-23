class PlaylistStreamersController < ApplicationController
  before_action :authenticate_admin!

  def new
    @playlist_streamer = PlaylistStreamer.new
    @streamers = Streamer.order(:name)
  end

  def create
    @playlist_streamer = @playlist.build_playlist_streamer(playlist_streamer_params)

    @playlist_streamer.save

    redirect_to @playlist, success: t('.success')
  end

  def edit
    @subscription_plan_streamer = SubscriptionPlanStreamer.find(params[:id])
    @subscription_plan = @subscription_plan_streamer.subscription_plan
    @streamers = Streamer.order(:name)
  end

  def update
    @subscription_plan_streamer = SubscriptionPlanStreamer.find(params[:id])
    @subscription_plan_streamer.update(subscription_plan_streamer_params)

    redirect_to @subscription_plan_streamer.subscription_plan, success: t('.success')
  end

  private

  def subscription_plan_streamer_params
    params.require(:subscription_plan_streamer).permit(:streamer_id)
  end

  def check_plan_type
    return if @subscription_plan.streamer?

    redirect_to @subscription_plan, notice: t('subscription_plan_streamers.check_plan_type.invalid')
  end
end
