class UserSubscriptionPlansController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :user_must_fill_profile
  before_action :set_subscription_plan

  def new
    UserSubscriptionPlan.new
  end

  def create
    @user_subscription_plan = current_user.user_subscription_plans.new(subscription_plan: @subscription_plan)

    if @user_subscription_plan.validate_payment && @user_subscription_plan.save
      redirect_to @subscription_plan, notice: t('.success')
    else
      render :new
    end
  end

  private

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end
end
