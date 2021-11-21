class SubscriptionPlanStreamersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_subscription_plan, only: %i[new create]
  before_action :check_plan_type, only: %i[new create]

  def new
    @subscription_plan_streamer = SubscriptionPlanStreamer.new
    @streamers = Streamer.order(:name)
  end

  def create
    @subscription_plan_streamer = @subscription_plan.build_subscription_plan_streamer(subscription_plan_streamer_params)

    @subscription_plan_streamer.save

    redirect_to @subscription_plan, success: t('.success')
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

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end

  def check_plan_type
    return if @subscription_plan.streamer?

    redirect_to @subscription_plan, notice: t('subscription_plan_streamers.check_plan_type.invalid')
  end
end
