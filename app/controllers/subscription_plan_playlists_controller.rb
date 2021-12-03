class SubscriptionPlanPlaylistsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create destroy]
  before_action :set_subscription_plan, only: %i[index new create]
  before_action :check_plan_type, only: %i[index new create]

  def index
    @subscription_plan_playlists = @subscription_plan.subscription_plan_playlists
  end

  def new
    @subscription_plan_playlist = SubscriptionPlanPlaylist.new
    @playlists = Playlist.where.not(id: @subscription_plan.playlists).order(:title).select(:id, :title)

    return unless @playlists.empty?

    redirect_to subscription_plan_subscription_plan_playlists_path(@subscription_plan), notice: t('.no_plans_available')
  end

  def create
    @subscription_plan_playlist = @subscription_plan.subscription_plan_playlists.new(subscription_plan_playlist_params)

    @subscription_plan_playlist.save

    redirect_to subscription_plan_subscription_plan_playlists_path(@subscription_plan), success: t('.success')
  end

  def destroy
    @subscription_plan_playlist = SubscriptionPlanPlaylist.find(params[:id])
    @subscription_plan = @subscription_plan_playlist.subscription_plan

    @subscription_plan_playlist.destroy

    redirect_to subscription_plan_subscription_plan_playlists_path(@subscription_plan), success: t('.success')
  end

  private

  def subscription_plan_playlist_params
    params.require(:subscription_plan_playlist).permit(:playlist_id)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end

  def check_plan_type
    return if @subscription_plan.playlist?

    redirect_to @subscription_plan, notice: t('subscription_plan_playlists.check_plan_type.invalid')
  end
end
