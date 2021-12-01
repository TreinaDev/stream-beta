class SubscriptionPlanValuesController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
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

  def edit
    @plan_value = SubscriptionPlanValue.find(params[:id])
  end

  def update
    @plan_value = SubscriptionPlanValue.find(params[:id])

    redirect_to @plan_value if @plan_value.update(subscription_plan_values_params)
  end

  def inactive_dinamic_plan_values
    @plan_value = SubscriptionPlanValue.find(params[:id])
    @plan_value.inactive!

    redirect_to @plan_value, success: t('.success')
  end

  private

  def subscription_plan_values_params
    params.require(:subscription_plan_value).permit(:start_date, :end_date, :value)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end
end
