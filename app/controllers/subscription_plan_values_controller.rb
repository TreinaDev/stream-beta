class SubscriptionPlanValuesController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create cancel]
  before_action :user_must_fill_profile
  before_action :set_subscription_plan, only: %i[index new create]

  def index
    @subscription_plan_values = @subscription_plan.subscription_plan_values
  end

  def new
    @subscription_plan_value = SubscriptionPlanValue.new
  end

  def create
    @subscription_plan_value = @subscription_plan.subscription_plan_values.new(subscription_plan_values_params)
    if @subscription_plan_value.save
      redirect_to subscription_plan_subscription_plan_values_path, success: t('.success')
    else
      render :new
    end
  end

  def cancel
    @subscription_plan_value = SubscriptionPlanValue.find(params[:id])
    @subscription_plan = @subscription_plan_value.subscription_plan

    @subscription_plan_value.canceled!

    redirect_to subscription_plan_subscription_plan_values_path(@subscription_plan), success: t('.success')
  end

  private

  def subscription_plan_values_params
    params.require(:subscription_plan_value).permit(:start_date, :end_date, :value)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end
end
