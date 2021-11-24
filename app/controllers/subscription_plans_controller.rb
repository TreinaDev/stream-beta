class SubscriptionPlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
  before_action :user_must_fill_profile

  def index
    @subscription_plans = SubscriptionPlan.all
  end

  def new
    @subscription_plan = SubscriptionPlan.new
  end

  def create
    @subscription_plan = SubscriptionPlan.new(subscription_plan_params)
    @subscription_plan.request_token

    if @subscription_plan.save
      redirect_to @subscription_plan, success: t('.success')
    else
      render :new
    end
  end

  def show
    @subscription_plan = SubscriptionPlan.find(params[:id])
    @user_subscription_plan = current_user&.user_subscription_plans&.find_by(subscription_plan: @subscription_plan)
  end

  private

  def subscription_plan_params
    params.require(:subscription_plan).permit(:title, :description, :value, :plan_type)
  end
end
