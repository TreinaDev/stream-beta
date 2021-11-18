class SubscriptionPlanValuesController < ApplicationController
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

  private

  def subscription_plan_values_params
    params.require(:subscription_plan_value).permit(:start_date, :end_date, :value)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end
end
